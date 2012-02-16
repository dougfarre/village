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

$(document).ready( function () {
});

function activate_ajax(title) {
	$(document).bind('ajax:success', function(e, data){ 
		var $tag = $('#temp_area');
		$tag.html(data);
		$tag.dialog({
			autoOpen: false, 
			modal: true,
			title: title,
			width: "500px"
		}).dialog('open');
	}); 
}

