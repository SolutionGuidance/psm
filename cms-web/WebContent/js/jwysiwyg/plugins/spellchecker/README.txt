Step 1:
-------
Include the necessary CSS and JS files:
<!-- Include RichText plugin -->
<link rel="stylesheet" href="${contextPath}/javascripts/jwysiwyg/jquery.wysiwyg.css" />
<script type="text/javascript" src="${contextPath}/javascripts/jwysiwyg/jquery.browser.js"></script>
<script type="text/javascript" src="${contextPath}/javascripts/jwysiwyg/jquery.wysiwyg.js"></script>
<script type="text/javascript" src="${contextPath}/javascripts/jwysiwyg/default.js"></script>
<!-- Custom spellchecker plugin for jWYSIWYG -->
<link rel="stylesheet" href="${contextPath}/javascripts/jwysiwyg/plugins/spellchecker/wysiwyg.spellchecker.css" />
<script type="text/javascript" src="${contextPath}/javascripts/jwysiwyg/plugins/spellchecker/wysiwyg.spellchecker.js"></script>


Step 2:
-------
Add a spellcheck control to the toolbar when instantiating your wysiwyg areas:

$.fn.wysiwyg ? $("textarea.richText").wysiwyg({
	controls: {
		spellcheck: {
			visible: true,
			groupIndex: 8,
			callbackArguments: [],
			tooltip: 'Spellcheck',
			exec: function(){
				$(this.editor).wysiwyg("Spellchecker.trigger", this);
			}
		}
	},
}) : null;

Step 3:
-------
Implement a server side controller that accepts the necessary parameters (see notes) and returns that all important spellcheck data.
(See SpellcheckController.java for a java example that uses the Spring framework and the Jazzy spell engine (http://jazzy.sourceforge.net/)

Step 4:
-------
Enjoy.

Notes:
------
When activated, the spellchecker plugin will generate a list of unique words to check and send them to your spellcheckUrl 
as space-separated string under the parameter name: words.
eg: words=mey dodgey werd list

Your server side code should then check these words against a dictionary and return the following schema:
{
	result: []
}
where the array is a list of the words that are suspect.
The spellchecker will then highlight these suspect words in your editor.
When you click on a highlighted word, another request will be sent, this time with a single name parameter pair:
word=<word to check for suggestions>
Your server side code should then compile a list of suggestions for this word and return it in the same format as before:
{
	result[<suggestions>]
}
If there are no suggestions simply return an empty array.
