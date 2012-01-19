$(document).ready(function(){


	$("#add_client").click(function(){
		add_input('clients');
		return false;
	});


	$("#add_stage").click(function(){
		add_input('stages');
		return false;
	});

	$("#add_service").click(function(){
		add_input('services');
		return false;
	});
	

	$(".modify").click(function(){
		id=$(this).attr('rel');
		$("#"+id).addClass('editable');
		return false;
	});
	
	$(".delete").click(function(){
		id=$(this).attr('rel');
		$("#"+id).remove();
		return false;
	});


  function add_input(type){
	
		value=$("#"+type+"_input").val();
		if(value!=""){
			id=Math.floor(Math.random()*1000)
			inputs=$("."+type+"_input").length;
			if(inputs%2==0)
			classs='gray';
			else
			classs='light-gray';
			input="<div class='"+classs+"' id='operating_cycle_"+type+"_attributes_new_"+id+"_div'> <div class='left'><input type='text' size='50' name='operating_cycle["+type+"_attributes][new_"+id+"][name]' id='operating_cycle_"+type+"_attributes_new_"+id+"_name' class='"+type+"_input' value='"+value+"'></div>"
			links='<div class="right"><a class="modify" href="" rel="operating_cycle_'+type+'_attributes_new_'+id+'_name"><img src="/images/editar_ico_up.png?" class="button_to_edit" alt="Editar_ico_up"></a><a rel="operating_cycle_'+type+'_attributes_new_'+id+'_div" data-method="delete" class="delete" href=""><img src="/images/borrar_ico_up.png" class="button_to_delete" alt="Borrar_ico_up"></a></div><div class="clear"></div></div>';
			$("#"+type).append(input+links);
			$("#"+type).removeClass("hidden");
			$("#"+type+"_input").val("");
			
			$(".modify").click(function(){
				id=$(this).attr('rel');
				$("#"+id).addClass('editable');
				return false;
			});
			
			$(".delete").click(function(){
				id=$(this).attr('rel');
				$("#"+id).remove();
				return false;
			});
		}
	
}

});