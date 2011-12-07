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
		
		
		return false;
		
		
		
	});
}
);