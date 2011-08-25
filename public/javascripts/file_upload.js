var file_number=1;

$('.selected-file').live({
  change: function() {
		$(this).removeClass('selected-file');
    $('div#upload-area').append('<input id="uploads_'+ file_number +'" class="selected-file" type="file" name="uploads['+ file_number +']">');
		file_number+=1;
  }
});
