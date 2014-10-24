# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(function(){

	$( "#close-account-button" ).click(function(event) {
		event.preventDefault();
	    $( "#change-password-box" ).hide();
	    $( "#close-account-box" ).show("slow");
	});

	$( "#change-password-button" ).click(function(event) {
	   	$( "#close-account-box" ).hide();
	    $( "#change-password-box" ).show("slow");
	});

});