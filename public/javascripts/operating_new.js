$(document).ready(function(){


	$("#add_client").click(function(){
		add_input('clients');
		$('#clients_input').val('Agregar Cliente');
		$(this).addClass('hidden');
		$('#clients_input').addClass('grey_input');
		return false;
	});


	$("#add_stage").click(function(){
		add_input('stages');
		$("#stages_input").val('Agregar Proceso');
		$(this).addClass('hidden');
		$("#stages_input").addClass('grey_input');
		return false;
	});


	$("#add_service").click(function(){
		add_input('services');
		return false;
	});


	$('.head').unbind('click');
	$('.head').click(function() {	
		id=$(this).attr('rel');
		$("#"+id).toggle('slow');
		return false;
	});




	$("#operating_cycle_submit").click(function(){
		$(" .no_edit_input").removeAttr("disabled");

	});



	dragAndDrop("stages","");
	dragAndDrop("services","");
	dragAndDrop("clients","");


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
		class_delete='delete '
		li_open="";
		li_close="";
		collapse=""


        ptype= type=="stages" ? "stages" : "input";

		$.get('/cycles/childs',{ id: id, value:value, type:type, classs:classs, ptype:ptype }, function(data) {

			$("#"+type+"_ul ").append(data);
			$("#"+type).removeClass("hidden");

			$("#"+type+"_input").val("");

			$('.head').unbind('click');
			$('.head').click(function() {	
				id=$(this).attr('rel');
				$("#"+id).toggle('slow');
				return false;
			});


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
				$("#"+id).parent().remove();
				return false;
			});

			
			$('.add_step').unbind('click');
			$(".add_step").click(function(){
				id=$(this).attr('rel');
				add_steps_input(id);
				return false;
			});

			$('.head').unbind('click');
			$('.head').click(function() {	
				id=$(this).attr('rel');
				$("#"+id).toggle('slow');

				return false;
			});

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


		$.get('/cycles/childs',{ id: id,id2:id2, value:value, type:"steps", classs:classs, ptype:"steps" }, function(data) {

			$("#steps_"+id+ " ul").append(data);
			$("#steps_"+id).removeClass("hidden");
			$("#steps_"+id+"_input").val("");


			dragAndDrop("steps",id);	

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

			$(".delete_step").click(function(){
				id=$(this).attr('rel');
				$("#"+id).remove();
				return false;
			});
			
			return false;

		});


	}


}




function dragAndDrop(type,id){

	if (type=="steps"){
		$("#"+type+"_"+id+" ul").sortable({ opacity: 0.6, cursor: 'move', update: function(){
			$("#"+type+"_"+id+" ul li").each(function(index){		
				ids=$(this).attr('rel').split(',');
				id1=ids[0];
				id2=ids[1];
				$("#operating_cycle_stages_attributes_"+id1+"_steps_attributes_"+id2+"_torder").val(index);
			});
		}
	});

}else{
	$("#"+type+"_ul").sortable({ opacity: 0.6, cursor: 'move', update: function(){
		$("#"+type+"_ul > div > li").each(function(index){
			id=$(this).attr('rel');		
			$("#operating_cycle_"+type+"_attributes_"+id+"_torder").val(index);
		});
	}
});

}


}

