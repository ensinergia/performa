jQuery(function(){
	
	$("#clients_input, #stages_input").click(function(){
		$(this).val('');
		$(this).removeClass('grey_input');
	});
	
	$("#clients_input, #stages_input").keyup(function(){
		type = $(this).attr('rel');
		if($.trim($(this).val()).length)
			$("#add_"+ type).removeClass('hidden');
		else
			$("#add_"+ type).addClass('hidden');
	}); //end key up
	
	$(".input_services").live({
		"click" : function(){
			$(this).val('');
			$(this).removeClass('grey_input');
		}, //end click function

		"keyup" : function(){
			var id_link = $(this).attr('id').match(/\d+/)[0];
			if($.trim($(this).val()).length)
				$("#add_step_" + id_link).removeClass('hidden');
			else
				$("#add_step_" + id_link).addClass('hidden');
		}
	});// end live function
});