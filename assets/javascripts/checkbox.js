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
	var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";

	for( var i=0; i < 5; i++ )
		text += possible.charAt(Math.floor(Math.random() * possible.length));

	return text;
}
$(function(){
	$('.controller-wiki.action-show .wiki-page').on('click', 'input', function(e){
		_this = $(this);
		__this = this;
		original_state = _this.prop('checked');
		_this.attr("disabled", "disabled");
		project_id = $('form').first().attr('action').replace( /\/projects\//, '' );
		project_id = project_id.replace( /\/search/, '' );
		wiki_page = window.location.href.split("/");
		state = _this.prop('checked') ? false : "checked"; //this needs to determine previous(before_click state)
		klass = $(this).attr('class');
		if (wiki_page[(wiki_page.length - 2)] == project_id)
		{wiki_page = "root"}
		else if (wiki_page[(wiki_page.length - 2)] == "wiki")
		{wiki_page = wiki_page[(wiki_page.length - 1)]}
		var type = window.location.href.indexOf("/wiki") > 0 ? "WikiPage" : "Issue";
		$.ajax({
			type: "GET",
			format: "script",
			url: "/update_checkbox_state",
			data: { type: type, project_id: project_id, wiki_page: wiki_page, state: state, klass: klass },
			success: function(data){
				_this.removeAttr("disabled")
			},
			error: function(data){
				console.log('Error happened, please ask Bill Gates to fix it');
				_this.removeAttr("disabled")
				if (_this.prop('checked'))
				{_this.prop("checked", "")}
				else
				{_this.prop('checked', 'checked');}
			}
		});
	});
});
