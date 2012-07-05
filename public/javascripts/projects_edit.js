$(document).ready(function() {
	$('#project_init_date').dateinput({ format: 'yyyy/mm/dd'});
	$('#project_final_date').dateinput({ format: 'yyyy/mm/dd'});

	models=["restriction","profit","project_objective","liabilitie","project_task","project_area","project_member"];
	models_es=["Supuesto o Restricción","Beneficio","Objetivo","Riesgo","Hito de Control","project_area","project_member"];

	for(i=0; i<models.length; i++){
		dragAndDrop(models[i]+"s","");
        $("#"+models[i]+"s_input").click(
			function(){	
				type=$(this).attr("rel");
				$("#add_"+type).removeClass("hidden");
				$(this).removeClass("add_input");		
				$(this).val("");		
			}
		);
		switch(models[i]){
			case "project_objective":
			$("#add_objective").click(function(){
				add_objectives_input();
				return false;
			});
			break;
			case "project_task":
			$("#add_project_task").click(function(){
				add_input('project_tasks');
				return false;
			});
			break;
			case "project_area":
			$("#add_area").click(function(){
				add_input_people('project_areas');
				return false;
			});
			break;
			case "project_member":
			$("#add_member").click(function(){
				add_input_member('project_members');
				return false;
			});
			break;
			default: 
			$("#add_"+models[i]).click(function(){	
				add_input($(this).attr('id').split('_')[1]+"s");
				return false;
			});

		}

	}


	$(".modify").click(function(){
		id=$(this).attr('rel');
		id2_array=id.split("_");
		id2_array[id2_array.length-1]="ptype";
		id2=id2_array.join("_");
		$("#"+id).addClass('editable');
		$("#"+id+"_close").removeClass('hidden');
		$("#"+id).removeAttr('disabled');
		$("#"+id2).addClass('editable');
		$("#"+id2).removeAttr('disabled');
		return false;
	});




	$(".close").click(function(){
		id=$(this).attr('rel');
		id2_array=id.split("_");
		id2_array[id2_array.length-1]="ptype";
		id2=id2_array.join("_");
		$("#"+id).removeClass('editable');
		$(this).addClass('hidden');
		$("#"+id2).removeClass('editable');
		$("#"+id).attr('disabled','disabled');
		$("#"+id2).attr('disabled','disabled');
		return false;
	});

	$(".delete").click(function(){
		div=$(this).attr('rel');
		st=div.split('_');
		console.log(div+">>"+st);
		if(st[3]=='new'){
			$("#"+div).remove();
		}else{
			id=st[5];
			type=st[1];
			if (type=="project"){

				type="project_"+st[2];
				id=st[6];
				console.log(type+ "---"+ id);
			}	
			console.log(div);
			des="<input type='text' name='project["+type+"_attributes]["+id+"][_destroy]' id='project_"+type+"_attributes_"+id+"_destroy' class='hidden' value='1'>"
			$("#"+div).append(des);
			$("#"+div).addClass('hidden');
		}
		return false;
	});


	$("#project_submit").click(function(){
		$(" .no_edit_input").removeAttr("disabled");
	});


});




function add_input(type){
	value=$("#"+type+"_input").val();
	if(value!=""){
		id=Math.floor(Math.random()*1000)+150;
		inputs=$("#"+type+"_ul > div > li ").length;
		if(inputs%2==0)
		classs='gray';
		else
		classs='blank_bg';
		size="85"
		inp='';



        

		ptype="";
		if(type=="restrictions"){
			ptype='<select name="project[restrictions_attributes][new_'+id+'][ptype]" id="project_restrictions_attributes_new_'+id+'_ptype" disabled="disabled" class="no_edit_input"><option value="restriccion">Restricción</option><option value="supuesto">Supuesto</option></select>';
			size="70";
		}

		if(type=="profits"){
			ptype='<select name="project[profits_attributes][new_'+id+'][ptype]" id="project_profits_attributes_new_'+id+'_ptype" disabled="disabled" class="no_edit_input"><option value="incremento">Incremento de Ingresos</option><option value="reduccion">Reducción de Costos</option></select>';
			size="55";
		}


		close='<a rel="project_'+type+'_attributes_new_'+id+'_name" id="project_'+type+'_attributes_new_'+id+'_name_close" href="" class="close hidden"><img src="/images/close.png" alt="Close"></a>';
		input="<div> <li rel='"+id+"'><div class='"+classs+"' id='project_"+type+"_attributes_new_"+id+"_div'><div class='left'><input type='text' size='"+size+"' name='project["+type+"_attributes][new_"+id+"][name]' id='project_"+type+"_attributes_new_"+id+"_name' class='no_edit_input ' value='"+value+"'>"+ptype+close+"</div><input type='hidden'  name='project["+type+"_attributes][new_"+id+"][torder]' id='project_"+type+"_attributes_"+id+"_torder' value='"+inputs+"'>"+inp
		links='<div class="right action" id="action_'+type+'_'+id+'"><a class="modify" href="" rel="project_'+type+'_attributes_new_'+id+'_name"><img src="/images/editar_ico_up.png?" class="button_to_edit" alt="Editar_ico_up"></a><a rel="project_'+type+'_attributes_new_'+id+'_div" data-method="delete" class="delete" href=""><img src="/images/borrar_ico_up.png" class="button_to_delete" alt="Borrar_ico_up"></a></div>';
		clear='<div class="clear"></div></div></li></div>';
		$("#"+type+"_ul ").append(input+links+clear);
		$("#"+type).removeClass("hidden");
		$("#"+type+"_input").val("");

		$(".modify").click(function(){
			id=$(this).attr('rel');
			id2_array=id.split("_");
			id2_array[id2_array.length-1]="ptype";
			id2=id2_array.join("_");
			$("#"+id).addClass('editable');
			$("#"+id+"_close").removeClass('hidden');
			$("#"+id).removeAttr('disabled');
			$("#"+id2).addClass('editable');
			$("#"+id2).removeAttr('disabled');
			return false;
		});




		$(".close").click(function(){
			id=$(this).attr('rel');
			id2_array=id.split("_");
			id2_array[id2_array.length-1]="ptype";
			id2=id2_array.join("_");
			$("#"+id).removeClass('editable');
			$(this).addClass('hidden');
			$("#"+id2).removeClass('editable');
			$("#"+id).attr('disabled','disabled');
			$("#"+id2).attr('disabled','disabled');
			return false;
		});

		$(".delete").click(function(){
			div=$(this).attr('rel');
			st=div.split('_');
			if(st[3]=='new' || st[4]=='new'){
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

	
    model_es="_"
	for(i=0; i<models.length; i++){
		if(models[i]==type.slice(0, -1)){
			model_es=models_es[i];
		}
	}

    $("#"+type+"_input").val("Agregar " + model_es);
	$("#"+type+"_input").addClass("add_input");
	$("#add_"+type.slice(0, -1)).addClass("hidden");
	listHover(type);

}



function add_objectives_input(){
	type="project_objectives";
	id_obj=$("#operative_objective").val();
	percent=$("#objectives_input").val();
	if(id_obj!="" & percent!=""){
		id=Math.floor(Math.random()*1000)+170;
		inputs=$("#project_objectives_ul > div > li").length;
		if(inputs%2==0)
		classs='gray';
		else
		classs='blank_bg';

		text=$("#operative_objective  option[value='"+id_obj+"']").text();

		inp1="<div class='left  hidden'>";
		inp2="<input type='text' value='"+id_obj+"' name='project[project_objectives_attributes][new_"+id+"][operative_objective_id]' id='project_operative_objectives_attributes_new_"+id+"_objective'></div>";
		inp=inp1+inp2;

		links='<div class="right action" id="action_'+type+'_'+id+'"><a class="modify" href="" rel="project_project_objectives_attributes_new_'+id+'_percent"><img src="/images/editar_ico_up.png?" class="button_to_edit" alt="Editar_ico_up"></a><a rel="project_project_objectives_attributes_new_'+id+'_div" data-method="delete" class="delete" href=""><img src="/images/borrar_ico_up.png" class="button_to_delete" alt="Borrar_ico_up"></a></div>';
		input="<div><li rel='"+id+"'><div class='"+classs+"' id='project_project_objectives_attributes_new_"+id+"_div'> <div class='left marginright10px'><div class='left width_60'> "+text+" </div>"+inp+links+"<div class='right marginright10px'>&nbsp; <strong>porcentaje</strong> <input type='text' class='no_edit_input align-right' value='"+percent+"'  name='project[project_objectives_attributes][new_"+id+"][percent]' id='project_project_objectives_attributes_new_"+id+"_percent' size='2'>%<input type='hidden'  name='project["+type+"_attributes][new_"+id+"][torder]' id='project_"+type+"_attributes_"+id+"_torder'></div>";

		clear='</div><div class="clear"></div></li></div>';
		$("#project_objectives_ul").append(input+clear);
		$("#objectives").removeClass("hidden");
		$("#objectives_input").val("");

		$(".modify").click(function(){
			id=$(this).attr('rel');
			$("#"+id).addClass('editable');
			$("#"+id+"_close").removeClass('hidden');
			$("#"+id).removeAttr('disabled');
			return false;
		});


		$(".close").click(function(){
			id=$(this).attr('rel');
			$("#"+id).removeClass('editable');
			$(this).addClass('hidden');
			$("#"+id).attr('disabled','disabled');
			return false;
		});

		$(".delete").click(function(){
			id=$(this).attr('rel');
			$("#"+id).remove();
			return false;
		});



	}


}


function add_input_people(type){
	id_obj=$("#"+type+"_select").val();
	project_id=$("#add_area").attr("rel");
	if(id_obj!=""){
		id=Math.floor(Math.random()*1000)+170;
		inputs=$("#"+type+"_ul > div > li").length;
		if(inputs%2==0)
		classs='gray';
		else
		classs='blank_bg';

		text=$("#"+type+"_select  option[value='"+id_obj+"']").text();

		inp1="<div class='left  hidden'><input type='text' value='"+id_obj+"' name='project[project_areas_attributes][new_"+id+"][area_id]' id='project_areas_attributes_new_"+id+"'>";
		inp2="<input type='hidden'  name='project[project_areas_attributes][new_"+id+"][torder]' id='project_"+type+"_attributes_"+id+"_torder'><input type='text' value='"+project_id+"' name='project[project_areas_attributes][new_"+id+"][project_id]' id='project_areas_attributes_new_"+id+"'>"+text+"</div>";
		inp=inp1+inp2;

		links='<div class="right action" id="action_'+type+'_'+id+'"><a rel="project_project_areas_attributes_new_'+id+'_div" data-method="delete" class="delete" href=""><img src="/images/borrar_ico_up.png" class="button_to_delete" alt="Borrar_ico_up"></a></div>';
		input="<div><li rel='"+id+"'><div class="+classs+" id='project_project_areas_attributes_new_"+id+"_div'>"+text+inp+links+"</div></div>";

		clear='<div class="clear"></div></li></div>';
		$("#"+type+"_ul").append(input+clear);



		$(".delete").click(function(){
			id=$(this).attr('rel');
			$("#"+id).remove();
			return false;
		});



	}

	listHover(type);

}


function add_input_member(type){
	id_obj=$("#"+type+"_select").val();
	role=$("#"+type+"_type_select").val();
	console.log(role);
	project_id=$("#add_member").attr("rel");
	if(id_obj!="" && role!=""){
		id=Math.floor(Math.random()*1000)+170;
		inputs=$("#"+type+"_ul > div > li").length;
		if(inputs%2==0)
		classs='gray';
		else
		classs='blank_bg';

		text=$("#"+type+"_select  option[value='"+id_obj+"']").text();

		inp1="<div class='left  hidden'><input type='text' value='"+id_obj+"' name='project[project_members_attributes][new_"+id+"][user_id]' id='project_members_attributes_new_"+id+"'><input type='text' value='"+role+"' name='project[project_members_attributes][new_"+id+"][role]' id='project_members_attributes_new_"+id+"'>";
		inp2="<input type='hidden'  name='project[project_members_attributes][new_"+id+"][torder]' id='project_"+type+"_attributes_"+id+"_torder'><input type='text' value='"+project_id+"' name='project[project_members_attributes][new_"+id+"][project_id]' id='project_members_attributes_new_"+id+"'>"+text+"</div>";
		inp=inp1+inp2;

		links='<div class="right action" id="action_'+type+'_'+id+'" ><span style="width:30px;margin-right:90px">'+role+'</span><a rel="project_project_members_attributes_new_'+id+'_div" data-method="delete" class="delete" href=""><img src="/images/borrar_ico_up.png" class="button_to_delete" alt="Borrar_ico_up"></a></div>';
		input="<div><li rel='"+id+"'><div class="+classs+" id='project_project_members_attributes_new_"+id+"_div'>"+text+inp+links+"</div></div>";

		clear='<div class="clear"></div></li></div>';
		$("#"+type+"_ul").append(input+clear);



		$(".delete").click(function(){
			id=$(this).attr('rel');
			$("#"+id).remove();
			return false;
		});



	}
		listHover(type);


}








function dragAndDrop(type,id){
	listHover(type);	
			
	$("#"+type+"_ul").sortable({ opacity: 0.6, cursor: 'move', update: function(){
		$("#"+type+"_ul > div > li").each(function(index){
			id=$(this).attr('rel');	
			$("#project_"+type+"_attributes_"+id+"_torder").val(index);
		});
	}
});

}

function listHover(type){
	$(".action").hide();
		$("#"+type+"_ul > div > li").each(function(index){		
				$(this).hover(function(){id=$(this).attr('rel');$("#action_"+type+"_"+id).show();});
				$(this).mouseleave(function(){id=$(this).attr('rel');$("#action_"+type+"_"+id).hide();});
			});
	
}

