$(document).ready(function(){


	$("#add_client").click(function(){
		add_input('clients');
		return false;
	});


	$("#add_stage").click(function(){
		add_input('stages');
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
		classs='light-gray';

		inp='';
		class_delete='delete '
		li_open="";
		li_close="";
		collapse=""
		
		
		
		
		
		close_edit='<a rel="operating_cycle_'+type+'_attributes_new_'+id+'_name" id="operating_cycle_'+type+'_attributes_new_'+id+'_name_close" href="" class="close hidden"><img src="/images/close.png" alt="Close"></a>';
		if (type=='stages'){
			steps='<div id="steps_'+id+'" class="hidden"><ul></u></div>';
			inp='<div class="clear"></div><div class="steps_container"><label><strong> Productos y/o Servicios </strong></label><br><br><div class="align-left left" style="width:100%"><input id="steps_'+id+'_input" style="width:60%"><a id="add_step_'+id+'" rel="'+id+'" href="" class="add_step">+ Agregar Producto y/o Servicio</a></div><div class="clear"></div><br/>'+steps+'</div>';

			class_delete='delete'
			collapse="<a rel='operating_cycle_"+type+"_attributes_new_"+id+"_div' href=''class='head'>+/-</a>";
			li_open="<li rel='"+id+"'>";
			li_close='</li>';

			input=li_open+"<div class='"+classs+"'><div class='left'>"+collapse+"<input type='text' disabled='disabled' size='85' name='operating_cycle["+type+"_attributes]["+id+"][name]' id='operating_cycle_"+type+"_attributes_new_"+id+"_name' class='no_edit_input' value='"+value+"'><input type='hidden'name='operating_cycle["+type+"_attributes]["+id+"][torder]' id='operating_cycle_"+type+"_attributes_"+id+"_torder' value='"+inputs+"'>"+close_edit+"</div>";
			links='<div class="right"><a class="modify" href="" rel="operating_cycle_'+type+'_attributes_new_'+id+'_name"><img src="/images/editar_ico_up.png?" class="button_to_edit" alt="Editar_ico_up"></a><a rel="operating_cycle_'+type+'_attributes_new_'+id+'_div" data-method="delete" class="'+class_delete+'" href=""><img src="/images/borrar_ico_up.png" class="button_to_delete" alt="Borrar_ico_up"></a></div>';
			clear='<div class="clear"></div></div><div class="'+classs+'" id="operating_cycle_'+type+'_attributes_new_'+id+'_div"> '+inp+' </div>'+li_close;

			$("#stages_container >  ul").append(input+links+clear);
			$("#stages").removeClass("hidden");
		}else{
			
			ptype="";
		
		size="85";
		
		if(type=="services"){
			ptype='<select name="operating_cycle[services_attributes]['+id+'][ptype]" id="operating_cycle_services_attributes_new_'+id+'_ptype" class="no_edit_input" disabled="disabled"><option value="Service">Servicio</option><option selected="selected" value="Product">Producto</option></select>';
			size="75";
		}
		
		
			
			class_delete='delete'
			li_open="<div><li rel='"+id+"'><input type='hidden' name='operating_cycle["+type+"_attributes]["+id+"][torder]' id='operating_cycle_"+type+"_attributes_"+id+"_torder' value='"+inputs+"'>";
			li_close='</li></div>';
			
			input=li_open+"<div class='"+classs+"'><div class='left'><input type='text' size='"+size+"' class='no_edit_input' disabled='disabled' name='operating_cycle["+type+"_attributes]["+id+"][name]' id='operating_cycle_"+type+"_attributes_new_"+id+"_name'  value='"+value+"'>"+ptype+close_edit+"</div>";
			links='<div class="right"><a class="modify" href="" rel="operating_cycle_'+type+'_attributes_new_'+id+'_name"><img src="/images/editar_ico_up.png?" class="button_to_edit" alt="Editar_ico_up"></a><a rel="operating_cycle_'+type+'_attributes_new_'+id+'_div" data-method="delete" class="'+class_delete+'" href=""><img src="/images/borrar_ico_up.png" class="button_to_delete" alt="Borrar_ico_up"></a></div>';
			clear='<div class="clear"></div></div><div class="'+classs+'" id="operating_cycle_'+type+'_attributes_new_'+id+'_div"> '+inp+' </div>'+li_close;
			$("#"+type+"_ul").append(input+links+clear);
			$("#"+type).removeClass("hidden");
		}



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
		close_edit='<a rel="operating_cycle_steps_attributes_new_'+id+'_'+id2+'_name" id="operating_cycle_steps_attributes_new_'+id+'_'+id2+'_name_close" href="" class="close hidden"><img src="/images/close.png" alt="Close"></a>';
		input="<li rel='"+id+","+id2+"'><div class='"+classs+"' id='operating_cycle_steps_attributes_new_"+id+"_"+id2+"_div'> <div class='left'><input type='text' disabled='disabled' size='75' name='operating_cycle[stages_attributes]["+id+"][steps_attributes][new_"+id2+"][name]' id='operating_cycle_steps_attributes_new_"+id+"_"+id2+"_name' class='no_edit_input' value='"+value+"'><input type='hidden' name='operating_cycle[stages_attributes]["+id+"][steps_attributes][new_"+id2+"][torder]' id='operating_cycle_stages_attributes_"+id+"_steps_attributes_"+id2+"_torder' value='"+inputs+"' >"+close_edit+"</div>"
		links='<div class="right"><a class="modify modify_step" href="" rel="operating_cycle_steps_attributes_new_'+id+'_'+id2+'_name"><img src="/images/editar_ico_up.png?" class="button_to_edit" alt="Editar_ico_up"></a><a rel="operating_cycle_steps_attributes_new_'+id+'_'+id2+'_div" data-method="delete" class="delete delete_step" href=""><img src="/images/borrar_ico_up.png" class="button_to_delete" alt="Borrar_ico_up"></a></div>';
		clear='<div class="clear"></div></div></li>';

		$("#steps_"+id+ " ul").append(input+links+clear);
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

