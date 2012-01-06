$.extend({
	exists: function(dom) {
		return $(dom).length;
	}
});

$(document).ready(function() {

	$('#area_selector').change(
		function(){
			document.location='areas/select?area_id='+$('#area_selector').val();
		}
	);



	$('#user_photo').attr('size','1');
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

	if($.exists('.hide-parent-div')) {
		$('.hide-parent-div').live('click', function() {
			var divToShow = $(this).closest('div');
			$(divToShow).addClass('hidden');
			$(divToShow).children('form')[0].reset();
		});
	}

	if($(".inline-analysis-value").length) {

		var id = $(".inline-analysis-value").parent().attr('id').split('-')[1];

		$(".inline-analysis-value").editable('/swot/analyses/'+id+'.js', {
			method : "PUT",
			indicator : 'Guardando...',
			tooltip : 'Click para modificar',
			submit : 'Guardar',
			cancel : 'Cancelar',
			name : 'analysis[content]'
		});
	}

	if($("#contextual-show-action-form").length) {
		$("#contextual-show-action-form").submit();
	}


	function remove_fields(link) {
		$(link).prev("input[type=hidden]").val("1");
		$(link).closest(".fields").hide();
	}

	function add_fields(link, association, content) {
		var new_id = new Date().getTime();
		var regexp = new RegExp("new_" + association, "g")
		$(link).parent().before(content.replace(regexp, new_id));
	}



	/* Activating Best In Place */
	jQuery(".best_in_place").best_in_place();
});