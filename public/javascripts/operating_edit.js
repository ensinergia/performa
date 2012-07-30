$(document).ready(function(){

	$('.head').unbind('click');
	$('.head').click(function() {	
		id=$(this).attr('rel');
		$("#"+id).toggle('slow');
		return false;
	});

	$(".collapse").toggle('slow');

	dragAndDrop("stages","");
	dragAndDrop("services","");
	dragAndDrop("clients","");


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
		if(div[4]=='new'){
			$("#"+div).remove();
		}else{
			st=div.split('_');
			id=st[6];
			type=st[2];

			des="<input type='text' name='operating_cycle["+type+"_attributes]["+id+"][_destroy]' id='operating_cycle_"+type+"_attributes_new_"+id+"_destroy' class='hidden' value='1'>"
			$("#"+div).append(des);
			if (type="stage")
			$("#"+div).prev().addClass('hidden');
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


	$("#operating_cycle_submit").click(function(){
		$(" .no_edit_input").removeAttr("disabled");
	});

});



function add_input(type){

	value=$("#"+type+"_input").val();
	if(value!=""){
		id=Math.floor(Math.random()*1000);
		inputs=$("#"+type+" .no_edit_input").length;
		if(inputs%2==0)
		classs='blank_bg';
		else
		classs='gray';


		inp='';
		collapse=""
		class_delete='delete '
		li_open="";
		li_close="";

		ptype= type=="stages" ? "stages" : "input";

		$.get('/cycles/childs',{ id: id, value:value, type:type, classs:classs, ptype:ptype }, function(data) {

			$("#"+type+"_ul ").append(data);
			$("#"+type).removeClass("hidden");

			$("#"+type+"_input").val("");




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
				id=$(this).attr('rel');
				$("#"+id).prev().addClass('hidden');
				$("#"+id).parent().remove();
				$("#"+id).remove();
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

			$(".close").click(function(){
				id=$(this).attr('rel');
				$("#"+id).removeClass('editable');
				$(this).addClass('hidden');
				$("#"+id).attr('disabled','disabled');
				return false;
			});

			dragAndDrop("stages",id);
		});

	}	

}


function add_steps_input(id){	
	value=$("#steps_"+id+"_input").val();
	if(value!=""){
		inputs=$("#steps_"+id+ " ul .no_edit_input").length;
		if(inputs%2==0)
		classs='gray';
		else
		classs='blank_bg';
		id2=Math.floor(Math.random()*1000)+160;
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

			$(".delete").click(function(){
				id=$(this).attr('rel');
				$("#"+id).prev().addClass('hidden');
				$("#"+id).remove();
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

