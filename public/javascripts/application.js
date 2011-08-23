$.extend({
	exists: function(dom) {
		return $(dom).length;
	}
});

$(document).ready(function() {
		
		$('#notice').delay(3500).fadeOut('slow');
    $('#alert').delay(3500).fadeOut('slow');
		
		if($.exists('.show-div')) {
			$('.show-div').live('click', function() {
				var divToShow = $(this).attr('id');
				$('div#'+divToShow).hide().removeClass('hidden');
				$('div#'+divToShow).fadeIn('slow');
			});
		}
});