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
		
		if($.exists('.hide-div')) {
			$('.hide-div').live('click', function() {
				var divToShow = $(this).attr('id');
				$('div#'+divToShow).addClass('hidden');
				$('div#'+divToShow+' form')[0].reset();
				$('div#'+divToShow+' form div#upload-area').addClass('hidden');
				$('div#'+divToShow+' form div#upload-area').html('<input id="uploads_0" class="" type="file" name="uploads[0]">');
			});
		}
		
});