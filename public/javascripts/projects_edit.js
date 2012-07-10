$(document).ready(function() {

	$('#project_init_date').dateinput({ format: 'yyyy/mm/dd'});
	$('#project_final_date').dateinput({ format: 'yyyy/mm/dd'});

	dateBehavior('#project_tasks_date_input');

	models=["restriction","profit","project_objective","liabilitie","project_task","project_area","project_member"];


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
