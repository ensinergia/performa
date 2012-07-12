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

function dateBehavior(id){
	$(id).dateinput({ format: 'yyyy/mm/dd'  });
	$('.date_input').click(function(){if ($(this).val()=="Fecha")$(this).val("");$('.date_input').removeClass("add_input");});
	$('.date_input').mouseleave(function(){if ($(this).val()==""){ $(this).val("Fecha");$('.date_input').addClass("add_input");} });
	$('.date_input').removeClass("date");
	
}





function add_input(type){

	value=$("#"+type+"_input").val();
	if(value!=""){
		id=Math.floor(Math.random()*1000)
		inputs=$("#"+type+"_ul > div > li").length;
		if(inputs%2==0)
		classs='gray';
		else
		classs='blank_bg';
		size="85";
		inp='';
		date_value=$("#project_tasks_date_input").val();
		date_value= date_value=="Fecha" ? "" : date_value; 

		$.get('/project/childs',{ id: id, value:value, size:size, date_value:date_value, type:type, classs:classs, ptype:"input" }, function(data) {
			$("#"+type+"_ul ").append(data);
			$("#"+type).removeClass("hidden");

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
				id=$(this).attr('rel');
				$("#"+id).remove();
				return false;
			});

			$("#"+type+"_input").val("Agregar otro");
			$("#"+type+"_input").addClass("add_input");
			$("#add_"+type.slice(0, -1)).addClass("hidden");
			id_date="#project_"+type+"_attributes_new_"+id+"_date";
			listHover(type);
			dateBehavior(id_date);

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

		$.get('/project/childs',{ id: id,text:text, type:type, classs:classs, ptype:"objective", percent:percent, id_obj:id_obj }, function(data) {
			if($("#project_objectives_ul").html().indexOf(text)==-1){

				$("#project_objectives_ul").append(data);
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

			listHover(type);

			return false;


		});

	}



}



function add_input_people(type){
	id_obj=$("#"+type+"_select").val();
	project_id=$("#add_area").attr("rel");
	console.log(id_obj+".."+project_id);
	if(id_obj!=""){
		id=Math.floor(Math.random()*1000)+170;
		inputs=$("#"+type+"_ul > div > li").length;
		if(inputs%2==0)
		classs='gray';
		else
		classs='blank_bg';

		text=$("#"+type+"_select  option[value='"+id_obj+"']").text();

		$.get('/project/childs',{ id: id,text:text,id_obj:id_obj,project_id:project_id, type:type, classs:classs, ptype:"people"}, function(data) {


			$("#"+type+"_ul").append(data);

			$(".delete").click(function(){
				id=$(this).attr('rel');
				$("#"+id).remove();
				return false;
			});


			listHover(type);

			return false;


		});	


	}




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

		$.get('/project/childs',{ id: id,text:text,id_obj:id_obj,project_id:project_id, type:type, classs:classs, ptype:"member", role:role}, function(data) {


			$("#"+type+"_ul").append(data);



			$(".delete").click(function(){
				id=$(this).attr('rel');
				$("#"+id).remove();
				return false;
			});

			listHover(type);

		});



	}
}



function add_input_with_select(type){
	id_value = $("#" + type + "_input").val();
	if(type == 'profits')
		option_selected = $("#project_profit_options").val();
	else
		option_selected = $("#project_restriction_options").val();

	if(id_value != "" && option_selected != ""){
		id = Math.floor(Math.random()*1000);
		inputs = $("#" + type + " .no_edit_input").length;
		
		if(inputs % 2 == 0)
			classs='gray';
		else
			classs='blank_bg';

		$.get('/project/childs',{ id:id, type:type, classs:classs, ptype:"input", option_selected:option_selected, value:id_value }, function(data) {
			$("#"+type+"_ul ").append(data);
			$("#"+type).removeClass("hidden");
			
			$(".modify").click(function(){
				id=$(this).attr('rel');
				id2_array=id.split("_");
				id2_array[id2_array.length-1]="ptype";
				id2=id2_array.join("_");
				$("#"+id).addClass('editable');
				$("#"+id+"_close").removeClass('hidden');
				var my_id = id.match(/\d*/)[0];
				$("#project_restrictions_attributes_new_" + my_id + "_ptype").removeAttr('disabled');
				$("#project_restrictions_attributes_new_" + my_id + "_ptype").addClass('editable');
				$("#project_restrictions_attributes_new_" + my_id + "_ptype").removeClass('hidden');
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
				id=$(this).attr('rel');
				$("#"+id).remove();
				return false;
			});	
			
			if(type == 'profits'){
				$("#project_profit_options").attr('disabled', 'disabled');
				$("#project_profit_options").addClass('no_edit_input');
			}else{
				$("#project_restriction_options").attr('disabled', 'disabled');
				$("#project_restriction_options").addClass('no_edit_input');
			}  
			
			$("#"+type+"_input").val("Agregar otro");
			$("#"+type+"_input").addClass("add_input");
			$("#add_"+type.slice(0, -1)).addClass("hidden");
			listHover(type);
			return false;
		});
	}
}