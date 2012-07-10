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
			$("#add_objective").unbind("click");
			$("#add_objective").bind("click",function(){
				add_objectives_input();
				return false;
			});
			break;
			case "project_task":
			$("#add_project_task").unbind("click");
			$("#add_project_task").click(function(){
				add_input('project_tasks');
				return false;
			});
			break;
			case "project_area":
			$("#add_area").unbind("click");
			$("#add_area").click(function(){
				add_input_people('project_areas');
				return false;
			});
			break;
			case "project_member":
			$("#add_member").unbind("click");
			$("#add_member").click(function(){
				add_input_member('project_members');
				return false;
			});
			break;
			default: 
			$("#add_"+models[i]).unbind("click");
			$("#add_"+models[i]).click(function(){	
				add_input($(this).attr('id').split('_')[1]+"s");
				return false;
			});

		}

	}


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


