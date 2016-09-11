/*jslint browser: true, forin: true, white: true */
(function(window, document, undefined) {

(function ($) {
	"use strict";
	/* Wysiwyg namespace: private properties and methods */

	var console = window.console || {
		log: $.noop,
		error: function (msg) {
			$.error(msg);
		}
	},
	supportsProp = ($.fn.prop !== undefined) && ($.fn.removeProp !== undefined);

	//= include "jwysiwyg/bc.js"

	//= include "jwysiwyg/private.js"

	/*
	 * Wysiwyg namespace: public properties and methods
	 */

	//= include "jwysiwyg/public.js"

	//= include "jwysiwyg/dialog.js"


	$.fn.wysiwyg = function (method) {
		var args = arguments, plugin;

		if ("undefined" !== typeof $.wysiwyg[method]) {
			// set argument object to undefined
			args = Array.prototype.concat.call([args[0]], [this], Array.prototype.slice.call(args, 1));
			return $.wysiwyg[method].apply($.wysiwyg, Array.prototype.slice.call(args, 1));
		} else if ("object" === typeof method || !method) {
			Array.prototype.unshift.call(args, this);
			return $.wysiwyg.init.apply($.wysiwyg, args);
		} else if ($.wysiwyg.plugin.exists(method)) {
			plugin = $.wysiwyg.plugin.parseName(method);
			args = Array.prototype.concat.call([args[0]], [this], Array.prototype.slice.call(args, 1));
			return $.wysiwyg[plugin.name][plugin.method].apply($.wysiwyg[plugin.name], Array.prototype.slice.call(args, 1));
		} else {
			console.error("Method '" +  method + "' does not exist on jQuery.wysiwyg.\nTry to include some extra controls or plugins");
		}
	};
	
	$.fn.getWysiwyg = function () {
		return this.data("wysiwyg");
	};

})(window.jQuery);

})(window, document);
