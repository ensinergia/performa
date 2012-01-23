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
		div=$(this).attr('rel');
		if(div[4]=='new'){
			$("#"+div).remove();
		}else{
			st=div.split('_');
			id=st[6];
			type=st[2];

			des="<input type='text' name='operating_cycle["+type+"_attributes]["+id+"][_destroy]' id='operating_cycle_"+type+"_attributes_new_"+id+"_destroy' class='hidden' value='1'>"
			$("#"+div).append(des);
			$("#"+div).addClass('hidden');
		}
		return false;
	});



	$(".add_step").click(function(){
		id=$(this).attr('rel');
		add_steps_input(id);
		return false;
	});
	
	
		$(".delete_step").click(function(){
			div=$(this).attr('rel');
			st=div.split('_');
			if(st[4]=='new'){
				$("#"+div).remove();
			}else{
				
				id=st[4];
				id2=st[6];
				des="<input type='text' name='operating_cycle[stages_attributes]["+id+"][steps_attributes]["+id2+"][_destroy]' id='operating_cycle_"+id+"_attributes_new_"+id2+"_destroy' class='hidden' value='1'>"
				$("#"+div).append(des);
				$("#"+div).addClass('hidden');
			}
			return false;
		});


});



function add_input(type){

	value=$("#"+type+"_input").val();
	if(value!=""){
		id=Math.floor(Math.random()*1000);
		inputs=$("#"+type+" .no_edit_input").length;
		if(inputs%2==0)
		classs='light-gray';
		else
		classs='gray';


		inp='';
		class_delete='delete '
		if (type=='stages'){
			steps='<div id="steps_'+id+'" class="hidden"></div>';
			inp='<div class="clear"></div><div class="steps_container"><label><strong> Pasos </strong></label><br><br><div class="align-left left" style="width:100%"><input id="steps_'+id+'_input" style="width:80%"><a id="add_step_'+id+'" rel="'+id+'" href="" class="add_step">+ Agregar Paso</a></div><div class="clear"></div><br/>'+steps+'</div>';
			class_delete='delete_step '

		}

		input="<div class='"+classs+"' id='operating_cycle_"+type+"_attributes_new_"+id+"_div'> <div class='left'><input type='text' size='50' name='operating_cycle["+type+"_attributes]["+id+"][name]' id='operating_cycle_"+type+"_attributes_new_"+id+"_name' class='no_edit_input' value='"+value+"'></div>"
		links='<div class="right"><a class="modify" href="" rel="operating_cycle_'+type+'_attributes_new_'+id+'_name"><img src="/images/editar_ico_up.png?" class="button_to_edit" alt="Editar_ico_up"></a><a rel="operating_cycle_'+type+'_attributes_new_'+id+'_div" data-method="delete" class="'+class_delete+'" href=""><img src="/images/borrar_ico_up.png" class="button_to_delete" alt="Borrar_ico_up"></a></div>';
		clear='<div class="clear"></div></div>';
		$("#"+type).append(input+links+inp+clear);
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


		$(".add_step").click(function(){
			id=$(this).attr('rel');
			add_steps_input(id);
			return false;
		});

	}	

}


function add_steps_input(id){	
	value=$("#steps_"+id+"_input").val();
	if(value!=""){
		inputs=$("#steps_"+id+" .no_edit_input").length;
		if(inputs%2==0)
		classs='gray';
		else
		classs='light-gray';
		id2=Math.floor(Math.random()*1000)
		input="<div class='"+classs+"' id='operating_cycle_steps_attributes_new_"+id+"_"+id2+"_div'> <div class='left'><input type='text' size='50' name='operating_cycle[stages_attributes]["+id+"][steps_attributes][new_"+id2+"][name]' id='operating_cycle_steps_attributes_new_"+id+"_"+id2+"_name' class='no_edit_input' value='"+value+"'></div>"
		links='<div class="right"><a class="modify modify_step" href="" rel="operating_cycle_steps_attributes_new_'+id+'_'+id2+'_name"><img src="/images/editar_ico_up.png?" class="button_to_edit" alt="Editar_ico_up"></a><a rel="operating_cycle_steps_attributes_new_'+id+'_'+id2+'_div" data-method="delete" class="delete delete_step" href=""><img src="/images/borrar_ico_up.png" class="button_to_delete" alt="Borrar_ico_up"></a></div>';
		clear='<div class="clear"></div></div>';

		$("#steps_"+id).append(input+links+clear);
		$("#steps_"+id).removeClass("hidden");
		$("#steps_"+id+"_input").val("");



		$(".modify_step").click(function(){
			id=$(this).attr('rel');
			$("#"+id).addClass('editable');
			return false;
		});

		$(".delete_step").click(function(){
			div=$(this).attr('rel');
			st=div.split('_');
			if(st[4]=='new'){
				$("#"+div).remove();
			}else{
				
				id=st[4];
				id2=st[6];
				des="<input type='text' name='operating_cycle[stages_attributes]["+id+"][steps_attributes]["+id2+"][_destroy]' id='operating_cycle_"+id+"_attributes_new_"+id2+"_destroy' class='hidden' value='1'>"
				$("#"+div).append(des);
				$("#"+div).addClass('hidden');
			}
			return false;
		});


	}

}