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
	
	$("#add_objective").click(function(){
			add_objectives_input();
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
			if (type=="project"){
				type="project_objectives"
				id=st[6];
			}	
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

			inp1="<div class='left marginright10px'><input type='checkbox' value='1' "+inc+" name='project["+type+"_attributes][new_"+id+"][incre]' id='project_"+type+"_attributes_new_"+id+"_incre'>"+inc_text+"</div>";
			inp2="<div class='left marginright10px'><input type='checkbox' value='1' "+dec+" name='project["+type+"_attributes][new_"+id+"][decre]' id='project_"+type+"_attributes_new_"+id+"_incre'>"+dec_text+"</div>";
			inp=inp1+inp2;
		}

		input="<div class='"+classs+"' id='project_"+type+"_attributes_new_"+id+"_div'> <div class='left'><input type='text' size='40' name='project["+type+"_attributes][new_"+id+"][name]' id='project_"+type+"_attributes_new_"+id+"_name' class='no_edit_input ' value='"+value+"'></div>"+inp
		links='<div class="right"><a class="modify" href="" rel="project_'+type+'_attributes_new_'+id+'_name"><img src="/images/editar_ico_up.png?" class="button_to_edit" alt="Editar_ico_up"></a><a rel="project_'+type+'_attributes_new_'+id+'_div" data-method="delete" class="delete" href=""><img src="/images/borrar_ico_up.png" class="button_to_delete" alt="Borrar_ico_up"></a></div>';
		clear='<div class="clear"></div></div>';
		$("#"+type).append(input+links+clear);
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




function add_objectives_input(){

	id_obj=$("#operative_objective").val();
	if(id_obj!=""){
		id=Math.floor(Math.random()*1000)
		inputs=$("#objectives .no_edit_input").length;
		if(inputs%2==0)
		classs='gray';
		else
		classs='blank_bg';
				
			text=$("#operative_objective  option[value='"+id_obj+"']").text();
			percent=$("#objectives_input").val();
			inp1="<div class='left  hidden'>";
			inp2="<input type='text' value='"+id_obj+"' name='project[project_objectives_attributes][new_"+id+"][operative_objective_id]' id='project_operative_objectives_attributes_new_"+id+"_objective'></div>";
			inp=inp1+inp2;
		
		input="<div class='"+classs+"' id='project_operative_objectives_attributes_new_"+id+"_div'> <div class='left marginright10px'><div class='left width_60'> "+text+" </div>"+inp+"<span class='marginright10px'>&nbsp;</span> <strong>porcentaje</strong> <input type='text' class='no_edit_input align-right' value='"+percent+"'  name='project[project_objectives_attributes][new_"+id+"][percent]' id='project_operative_objectives_attributes_new_"+id+"_percent' size='2'>%</div>";
		links='<div class="right"><a class="modify" href="" rel="project_operative_objectives_attributes_new_'+id+'_percent"><img src="/images/editar_ico_up.png?" class="button_to_edit" alt="Editar_ico_up"></a><a rel="project_operative_objectives_attributes_new_'+id+'_div" data-method="delete" class="delete" href=""><img src="/images/borrar_ico_up.png" class="button_to_delete" alt="Borrar_ico_up"></a></div>';
		clear='<div class="clear"></div></div>';
		$("#objectives").append(input+links+clear);
		$("#objectives").removeClass("hidden");
		$("#objectives_input").val("");

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

