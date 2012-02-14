$(document).ready(function() {
	$('#project_init_date').dateinput({ format: 'yyyy/mm/dd'});
	$('#project_final_date').dateinput({ format: 'yyyy/mm/dd'});


	dragAndDrop("restrictions","");
	dragAndDrop("profits","");
	dragAndDrop("project_objectives","");
	dragAndDrop("liabilities","");

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


	$(".close").click(function(){
		id=$(this).attr('rel');
		$("#"+id).removeClass('editable');
		$(this).addClass('hidden');
		$("#"+id).attr('disabled','disabled');
		return false;
	});


	$("#add_objective").click(function(){
		add_objectives_input();
		return false;
	});


	$(".modify").click(function(){
		id=$(this).attr('rel');
		$("#"+id).addClass('editable');
		$("#"+id+"_close").removeClass('hidden');
		$("#"+id).removeAttr('disabled');
		return false;
	});

	$(".delete").click(function(){
		id=$(this).attr('rel');
		$("#"+id).remove();
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
		size="85";
		inp='';
		if (type=='profits'){

			inc=$("#inc_0").attr("checked");
			if (inc==undefined)
			inc="";
			else	
			inc="checked='checked'"

			dec=$("#dec_0").attr("checked");

			if (dec==undefined)
			dec="";
			else	
			dec="checked='checked'"


			inc_text=$("#increment").html();
			dec_text=$("#decrement").html();

			inc_text=$("#increment").html();
			dec_text=$("#decrement").html();

			inp1="<div class='left marginright10px'><input type='checkbox' value='1' "+inc+" name='project["+type+"_attributes][new_"+id+"][incre]' id='project_"+type+"_attributes_new_"+id+"_incre'>"+inc_text+"</div>";
			inp2="<div class='left marginright10px'><input type='checkbox' value='1' "+dec+" name='project["+type+"_attributes][new_"+id+"][decre]' id='project_"+type+"_attributes_new_"+id+"_incre'>"+dec_text+"</div>";
			inp=inp1+inp2;

			size="20";
		}
		
		close='<a rel="project_'+type+'_attributes_new_'+id+'_name" id="project_'+type+'_attributes_new_'+id+'_name_close" href="" class="close hidden"><img src="/images/close.png" alt="Close"></a>';
		input="<div> <li rel='"+id+"'><div class='"+classs+"' id='project_"+type+"_attributes_new_"+id+"_div'><div class='left'><input type='text' size='"+size+"' name='project["+type+"_attributes][new_"+id+"][name]' id='project_"+type+"_attributes_new_"+id+"_name' class='no_edit_input ' value='"+value+"'>"+close+"</div><input type='hidden'  name='project["+type+"_attributes][new_"+id+"][torder]' id='project_"+type+"_attributes_"+id+"_torder'>"+inp;
		links='<div class="right"><a class="modify" href="" rel="project_'+type+'_attributes_new_'+id+'_name"><img src="/images/editar_ico_up.png?" class="button_to_edit" alt="Editar_ico_up"></a><a rel="project_'+type+'_attributes_new_'+id+'_div" data-method="delete" class="delete" href=""><img src="/images/borrar_ico_up.png" class="button_to_delete" alt="Borrar_ico_up"></a></div>';
		clear='<div class="clear"></div></div></li></div>';
		$("#"+type+"_ul ").append(input+links+clear);
		$("#"+type).removeClass("hidden");
		$("#"+type+"_input").val("");


		$(".close").click(function(){
			id=$(this).attr('rel');
			$("#"+id).removeClass('editable');
			$(this).addClass('hidden');
			$("#"+id).attr('disabled','disabled');
			return false;
		});

		$(".modify").click(function(){
			id=$(this).attr('rel');
			$("#"+id).addClass('editable');
			$("#"+id+"_close").removeClass('hidden');
			$("#"+id).removeAttr('disabled');
			return false;
		});

		$(".delete").click(function(){
			id=$(this).attr('rel');
			$("#"+id).remove();
			return false;
		});



	}

}





function add_objectives_input(){
	type="project_objectives";
	id_obj=$("#operative_objective").val();
	percent=$("#objectives_input").val();
	if(id_obj!="" & percent!=""){
		id=Math.floor(Math.random()*1000)
		inputs=$("#objectives .no_edit_input").length;
		if(inputs%2==0)
		classs='gray';
		else
		classs='blank_bg';

		text=$("#operative_objective  option[value='"+id_obj+"']").text();

		inp1="<div class='left  hidden'>";
		inp2="<input type='text' value='"+id_obj+"' name='project[project_objectives_attributes][new_"+id+"][operative_objective_id]' id='project_operative_objectives_attributes_new_"+id+"_objective'></div>";
		inp=inp1+inp2;

		input="<div><li rel='"+id+"'><div class='"+classs+"' id='project_project_objectives_attributes_new_"+id+"_div'> <div class='left marginright10px'><div class='left width_60'> "+text+" </div>"+inp+"<span class='marginright10px'>&nbsp;</span> <strong>porcentaje</strong> <input type='text' class='no_edit_input align-right' value='"+percent+"'  name='project[project_objectives_attributes][new_"+id+"][percent]' id='project_project_objectives_attributes_new_"+id+"_percent' size='2'>%<input type='hidden'  name='project["+type+"_attributes][new_"+id+"][torder]' id='project_"+type+"_attributes_"+id+"_torder'>";
		links='<div class="right"><a class="modify" href="" rel="project_project_objectives_attributes_new_'+id+'_percent"><img src="/images/editar_ico_up.png?" class="button_to_edit" alt="Editar_ico_up"></a><a rel="project_project_objectives_attributes_new_'+id+'_div" data-method="delete" class="delete" href=""><img src="/images/borrar_ico_up.png" class="button_to_delete" alt="Borrar_ico_up"></a></div>';
		clear='</div><div class="clear"></div></li></div>';
		$("#project_objectives_ul").append(input+links+clear);
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



function dragAndDrop(type,id){
	$("#"+type+"_ul").sortable({ opacity: 0.6, cursor: 'move', update: function(){
		$("#"+type+"_ul > div > li").each(function(index){
			id=$(this).attr('rel');	
			$("#project_"+type+"_attributes_"+id+"_torder").val(index);
		});
	}
});

}
