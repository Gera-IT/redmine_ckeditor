if (!RedactorPlugins) var RedactorPlugins = {};

(function($)
{
	RedactorPlugins.checkbox = function()
	{
		return {
			init: function()
			{
				var button = this.button.add('checkbox', 'Checkbox');
				this.button.addCallback(button, this.checkbox.show);

			},
			set: function(size)
			{

			},

			show: function()
			{
				_klass = makeid();
				this.insert.htmlWithoutClean("<input type='checkbox' name='asd' value='asd' class=" + _klass + ">");
				this.caret.setAfter($('.' + _klass))
			},
			reset: function()
			{

			}
		};
	};
})(jQuery);


$(document).on('click','.redactor-editor input[type=checkbox]',function(){
	klass = $(this).attr('class');
	$(this).attr('checked', this.checked);
	$('#content_text').redactor('code.sync');
	//$(this).
});


function makeid()
{
	var text = "";
	var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

	for( var i=0; i < 5; i++ )
		text += possible.charAt(Math.floor(Math.random() * possible.length));

	return text;
}
$(function(){
	$('.controller-wiki.action-show .wiki-page').on('click', 'input', function(e){
		e.preventDefault();
	});
});
