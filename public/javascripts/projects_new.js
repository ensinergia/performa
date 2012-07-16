$(document).ready(function() {

	$('#project_init_date').dateinput({ format: 'yyyy/mm/dd'});
	$('#project_final_date').dateinput({ format: 'yyyy/mm/dd'});

	dateBehavior('#project_tasks_date_input');

	models=["restriction","profit","project_objective","liabilitie","project_task","project_area","project_member"];


	for(i=0; i<models.length; i++){
		dragAndDrop(models[i]+"s","");
		$("#"+models[i]+"s_input").click(
			function(){
				$(this).removeClass("add_input");
				$(this).val("");
				//enable_select_box();
				var type_model = $(this).attr("rel");
				var selector = "#project_" + type_model + "_options";
				$(selector).removeAttr("disabled");
				$(selector).removeClass('no_edit_input');
			}
		);
		
		// show the "add someting" when the user type in the inputs
		$("#"+models[i]+"s_input").keyup(
			function(){
				type = $(this).attr("rel");
				if($.trim($(this).val()).length){
					$("#add_" + type).removeClass("hidden");
				}else{
					$("#add_" + type).addClass("hidden");
				} //end if 
			} // end function
		); //end keyup

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
			case "profit":
			$("#add_"+models[i]).unbind("click");
			$("#add_"+models[i]).click(function(){	
				add_input_with_select('profits');
				return false;
			});
			break;
			case "restriction":
			$("#add_"+models[i]).unbind("click");
			$("#add_"+models[i]).click(function(){	
				add_input_with_select('restrictions');
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
	
	$("#areas_input").click(function(){
		$("#areas_input").hide();
		$("#project_areas_select").removeClass('hidden');
	});
	
	$("#project_areas_select").change(function(){
		$("#add_area").removeClass('hidden');
	});
	
	$("#member_input").click(function(){
		$("#member_input").hide();
		$("#project_members_type_select").removeClass('hidden');
		$("#project_members_select").removeClass('hidden');
	});
	
	$("#project_members_type_select").change(function(){
		$("#add_member").removeClass('hidden');
	});

});


