$(document).ready(function(){
	$(".new_person").click(function(){
		$(".area-form").html("");
		id=$(this).attr('rel');
		form=$('#new-person').html();
		$("#area-form-"+id).html("");
		$("#area-form-"+id).html(form);
		$("#user_area_id").val(id);

		$(".cancel_person").click(function(){
			$(".area-form").html("");
			return false;
		});






		$(".validation").validator({
			effect: 'wall',
			container: '#errors',
			lang: 'es',
			// do not validate inputs when they are edited
			errorInputEvent: null

			// custom form submission logic
		}).submit(function(e)  {

			// when data is valid
			if (!e.isDefaultPrevented()) {

				// tell user that everything is OK
				$("#errors").html("<h2>Correcto!</h2>");

				// prevent the form data being submitted to the server
				//e.preventDefault();
			}

		});

		return false;



	});
}
);