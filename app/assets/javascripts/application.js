// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require jquery.remotipart
//= require_tree .
function getURLParameter(name) { 
return decodeURI((RegExp(name + '=' + '(.+?)(&|$)').exec(location.search)||[,null])[1]);
}

$(document).ready( function () {
	//$('#tab-container').easytabs({defaultTab: 'li#tab2'});
	/*$('input:submit').each(function () {
		$(this).replaceWith('<button type="submit">' + $(this).val() +	'</button>');
	});
	$('button').button();
	*/
	/*var $input_selector = $('input:text, input[type=number]');
	//$('input[type=text], input[type=email]').button().addClass('input_field');
	$input_selector..addClass('input_field');*/

	$('#home_email').live('click', function () {
		$(this).val('');
		$(this).removeClass('start_style');
		$(this).addClass('end_style');
	});

	if (getURLParameter('email') != 'null') {
		$('#user_email').val(getURLParameter('email'));
	}
});

	function activate_ajax(title) {
	$(document).bind('ajax:success', function(e, data){ 
		var $tag = $('#temp_area');
		$tag.html(data);
		$tag.dialog({
			autoOpen: false, 
			modal: true,
			title:  $tag.find('#title').text()/*title*/,
			width: "500px"
		}).dialog('open');
	}); 
}

