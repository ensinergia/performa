$(document).ready(function() {
	$('#project_init_date').dateinput({ format: 'yyyy/mm/dd'});
	$('#project_final_date').dateinput({ format: 'yyyy/mm/dd'});


	$("#add_profit").click(function(){
		add_input('profits');
		return false;
	});


	$("#add_liabilitie").click(function(){
		add_input('liabilities');
		return false;
	});


	$("#add_restriction").click(function(){
		add_input('restrictions');
		return false;
	});


	$(".modify").click(function(){
		id=$(this).attr('rel');
		$("#"+id).addClass('editable');
		return false;
	});

	$(".delete").click(function(){
		div=$(this).attr('rel');
		st=div.split('_');
		if(st[3]=='new'){
			$("#"+div).remove();
		}else{
			id=st[5];
			type=st[1];
			des="<input type='text' name='project["+type+"_attributes]["+id+"][_destroy]' id='project_"+type+"_attributes_"+id+"_destroy' class='hidden' value='1'>"
			$("#"+div).append(des);
			$("#"+div).addClass('hidden');
		}
		return false;
	});

});




function add_input(type){

	value=$("#"+type+"_input").val();
	if(value!=""){
		id=Math.floor(Math.random()*1000)
		inputs=$("#"+type+" .no_edit_input").length;
		if(inputs%2==0)
		classs='gray';
		else
		classs='blank_bg';

		inp='';
		if (type=='stages'){
			steps='<div id="steps_'+id+'" class="hidden"></div>';
			inp='<div class="clear"></div><div class="steps_container"><label><strong> Pasos </strong></label><br><br><div class="align-left left" style="width:100%"><input id="steps_'+id+'_input" style="width:80%"><a id="add_step_'+id+'" rel="'+id+'" href="" class="add_step">+ Agregar Paso</a></div><div class="clear"></div><br/>'+steps+'</div>';

		}

		input="<div class='"+classs+"' id='project_"+type+"_attributes_new_"+id+"_div'> <div class='left'><input type='text' size='50' name='project["+type+"_attributes][new_"+id+"][name]' id='project_"+type+"_attributes_new_"+id+"_name' class='no_edit_input ' value='"+value+"'></div>"
		links='<div class="right"><a class="modify" href="" rel="project_'+type+'_attributes_new_'+id+'_name"><img src="/images/editar_ico_up.png?" class="button_to_edit" alt="Editar_ico_up"></a><a rel="project_'+type+'_attributes_new_'+id+'_div" data-method="delete" class="delete" href=""><img src="/images/borrar_ico_up.png" class="button_to_delete" alt="Borrar_ico_up"></a></div>';
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
			div=$(this).attr('rel');
			st=div.split('_');
			if(st[3]=='new'){
				$("#"+div).remove();
			}else{
				id=st[5];
				type=st[1];
				des="<input type='text' name='project["+type+"_attributes]["+id+"][_destroy]' id='project_"+type+"_attributes_"+id+"_destroy' class='hidden' value='1'>"
				$("#"+div).append(des);
				$("#"+div).addClass('hidden');
			}
			return false;
		});


	}

}
