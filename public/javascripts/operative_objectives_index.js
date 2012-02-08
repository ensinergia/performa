$(document).ready(function() {

	$('.head').unbind('click');
	$('.head').click(function() {	
		id=$(this).attr('rel');
		$("#"+id).toggle('slow');
		return false;
	});

	$(".collapse").toggle('slow');			



});

google.load('visualization', '1', {packages:['gauge']});