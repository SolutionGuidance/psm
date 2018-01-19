(function($) {
    // Check that jWYSIWYG was loaded
    if (undefined === $.wysiwyg) {
        throw "wysiwyg.spellchecker.js depends on $.wysiwyg";
    }
	var DomWalker = {
		walk: function(element, callback, scope) {
			scope = scope || this;
			var node = element.firstChild;
			while (node) {
				var nextNode = node.nextSibling;
				callback.call(scope, node);
				if(node.childNodes && node.childNodes.length > 0){
					DomWalker.walk(node, callback, scope);
				}
				node = nextNode;
			}
			return element;
		}
	};
	
    // plugin
    var Spellchecker = {
        name: "Spellchecker",

        // plugin defaults
        defaults: {
			spellcheckUrl: $CONTEXT_PATH + '/spellcheck.html',
			spellwordCss: {
				'border-bottom': 'dashed 1px red',
				'cursor': 'pointer'
			}
		},

		separators: '\\s!"#$%&()*+,-./:;<=>?@[\]^_{|}§©«®±¶·¸»¼½¾¿×÷¤\u201d\u201c',
		
		readOnlyHandler: function(event){
			event.preventDefault();
			return false;
		},
		
		disableEditor: function(instance){
			instance.ui.toolbar.find("li").each(function () {
				var li = $(this);
				if(!li.hasClass("spellcheck")){
					li.addClass("disabled");
				} else {
					li.addClass("always-active");														
				}
			});														

			$(instance.editorDoc.body).bind("keypress", this.readOnlyHandler);		
		},
		
		enableEditor: function(instance){
			instance.ui.toolbar.find("li").each(function () {
				var li = $(this);
				li.removeClass("disabled");
			});

			$(instance.editorDoc.body).unbind("keypress", this.readOnlyHandler);
			instance.ui.toolbar.find(".spellcheck").removeClass("always-active");
		},
				
		getSeparatorRe: function(){
			var re = '';
			for (var i = 0;  i < this.separators.length; i++){
				re += '\\' + this.separators.charAt(i);
			}
			return re;
		},
				
		getRawWords: function(instance){
			var content = '';
			var node = instance.editorDoc.body;
			DomWalker.walk(node, function(n) {
				if (n.nodeType == 3){
					content += n.nodeValue + ' ';
				}
			});

			var re = this.getSeparatorRe();
			// Split words by separator
			content = content.replace(new RegExp('([0-9]|[' + re + '])', 'g'), ' ');
			content = content.replace(/(\s+)/g, ' ');
			content = $.trim(content);
			return $A(content.split(' ')).uniq().join(' ');	//Requires Prototype JS
		},
		
		processCheckedWords: function(instance, data, status, xhr){		
			var body = instance.editorDoc.body;
			var editor = instance.editor;
			var re = this.getSeparatorRe();
			var rx = new RegExp('(^|[' + re + '])(' + data.result.join("|") + ')(?=[' + re + ']|$)', 'g');
			var self = this;

			DomWalker.walk(body, function(n) {
				if (n.nodeType == 3){
					if(rx.test(n.nodeValue)){
						var elem = $('<span/>', {"class":"wysiwyg-hidden", "html": n.nodeValue.replace(rx, '$1<span class="wysiwyg-spellword">$2</span>')})[0];
						n.parentNode.replaceChild(elem, n);
						//Requires Prototype JS
						Element.getElementsBySelector(elem, "span.wysiwyg-spellword").each(function(spellword){
							$(spellword).css(self.defaults.spellwordCss);
							$(spellword).on("click", function(evt){

							var spellwordCt = $("#wysiwyg-spellword-suggestions")[0];
								if(spellwordCt){
									spellwordCt.parentNode.removeChild(spellwordCt);
								}
																					
								var top = editor.offset().top + $(Event.element(evt)).position().top + $(Event.element(evt)).height();
								var left = editor.offset().left + $(Event.element(evt)).position().left + ($(Event.element(evt)).width()/2) - (150/2);
																					
								spellwordCt = $("<div/>", {id:"wysiwyg-spellword-suggestions", "contenteditable":false, "unselectable":"on", "style":"left:" + left + "px;top:" + top + "px;"})[0]; 
								document.body.appendChild(spellwordCt);
								
								var close = $('<span/>', {"class":"button radius tiny close", "unselectable":"on", "html":"&times;"})[0];																				
								close.on("click", function(){ spellwordCt.parentNode.removeChild(spellwordCt); });
								spellwordCt.appendChild(close);
	
								var ctList = $('<ul/>', {"unselectable":"on"})[0];
								spellwordCt.appendChild(ctList);
																
								$.ajax({
									url: self.defaults.spellcheckUrl,
									type: "POST",
									data: {
										'word': spellword.innerHTML
									}, 
									success: function(data, status, xhr){
										if(data.result.length == 0){
											ctList.appendChild($("<li/>", {"unselectable":"on", "text": "There were no suggestions"})[0]);
										} else {
											$(data.result).each(function(idx, item){
												var el = $("<li/>", {"unselectable":"on", "text":item})[0];
												el.on("click", function(li){
													var fixed = document.createTextNode(item);
													spellword.parentNode.replaceChild(fixed, spellword);
													spellwordCt.parentNode.removeChild(spellwordCt);																				
												});
												ctList.appendChild(el);
											});
										}
									}
								});
							});
						}, this);
					}
				}
			}, this);
		},
		
		startChecking: function(editor){
			this.disableEditor(editor);
			var control = editor.ui.toolbar.find(".spellcheck");
			var body = editor.editorDoc.body;
			
			var rawWords = this.getRawWords(editor);
			
			$.ajax({
				url: this.defaults.spellcheckUrl, 
				type: "POST",
				data: {
					words: rawWords
				},
				success: this.processCheckedWords.bind(this, editor)
			});
			
		},
		
		stopChecking: function(editor){
			var editorDoc = editor.editorDoc, ui = editor.ui;

			Element.getElementsBySelector(editorDoc.body, "span.wysiwyg-spellword").each(function(spellchecked){
				var fixed = document.createTextNode(spellchecked.innerHTML);
				spellchecked.parentNode.replaceChild(fixed, spellchecked);
			});
			
			Element.getElementsBySelector(editorDoc.body, "span.wysiwyg-hidden").each(function(spellchecked){
				var fixed = document.createTextNode(spellchecked.innerHTML);
				spellchecked.parentNode.replaceChild(fixed, spellchecked);
			});

			this.enableEditor(editor);
		},
		
		trigger: function(object, editor){
			var control = editor.ui.toolbar.find(".spellcheck");
			if(control.hasClass("always-active")){
				this.stopChecking(editor);
			} else {
				this.startChecking(editor);
			}
		}
    };
    // Register your plugin
    $.wysiwyg.plugin.register(Spellchecker);
})(jQuery);