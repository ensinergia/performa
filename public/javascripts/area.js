$(document).ready(function() {

	dragAndDrop("area_supports","");

		if ($("#area_alevel").val()=="2"){
			$("#parent_area").show();
			$("#area_parent_id").attr("required", "required");
		}else{
			$("#parent_area").hide();
			$("#area_parent_id").val(1);
			$("#area_parent_id").removeAttr("required");
		}

	$("#area_alevel").change(function(){
		if ($(this).val()=="2"){
			$("#parent_area").show();
			$("#area_parent_id").attr("required", "required");
		}else{
			$("#parent_area").hide();
			$("#area_parent_id").val(1);
			$("#area_parent_id").removeAttr("required");
		}
		return false;
	});


	$("#add_parent").click(function(){
		add_input('area_supports');
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
		div=$(this).attr('rel');
		st=div.split('_');
		if(st[5]=='new'){
			$("#"+div).remove();
		}else{

			id=st[4];
			id2=st[6];
			des="<input type='text' name='area[area_supports_attributes]["+id+"][_destroy]' id='area_area_supports_attributes_new_"+id+"_destroy' class='hidden' value='1'>"
			$("#"+div).append(des);
			$("#"+div).addClass('hidden');
		}
		return false;
	});
	
	
		$("#area_submit").click(function(){
		$(" .no_edit_input").removeAttr("disabled");
	});
	

});





function add_input(type){

	value=$("#area_selector_inner").val();
	if(value!="" && $("#"+value).length==0) {
		supported_id=value;
		value=$('#area_selector_inner option:selected').text()
		id=supported_id;
		inputs=$("#"+type+"_ul > div > li ").length;
		if(inputs%2==0)
		classs='gray';
		else
		classs='blank_bg';
		
		size="1";
		close='<a rel="area_'+type+'_attributes_'+id+'_name" id="area_'+type+'_attributes_'+id+'_name_close" href="" class="close hidden"><img src="/images/close.png" alt="Close"></a>';
		input="<div> <li id='"+id+"' rel='"+id+"'><div class='"+classs+"' id='area_"+type+"_attributes_"+id+"_new'><div class='left'><input type='text' size='"+size+"' name='area["+type+"_attributes][new_"+id+"][supported_id]' id='area_"+type+"_attributes_"+id+"_supported_id' class=' hidden no_edit_input ' value='"+supported_id+"'>"+value+close+"</div><input type='hidden'  name='area["+type+"_attributes][new_"+id+"][torder]' id='area_"+type+"_attributes_"+id+"_torder' value='"+inputs+"'>";
		links='<div class="right"><a rel="area_'+type+'_attributes_'+id+'_new" data-method="delete" class="delete" href=""><img src="/images/borrar_ico_up.png" class="button_to_delete" alt="Borrar_ico_up"></a></div>';
		clear='<div class="clear"></div></div></li></div>';
		$("#"+type+"_ul").append(input+links+clear);
		$("#"+type).removeClass("hidden");
		$("#area_selector").val("");


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
		if(st[5]=='new'){
			$("#"+div).remove();
		}else{

			id=st[4];
			id2=st[6];
			des="<input type='text' name='area[area_supports_attributes]["+id+"][_destroy]' id='area_area_supports_attributes_new_"+id+"_destroy' class='hidden' value='1'>"
			$("#"+div).append(des);
			$("#"+div).addClass('hidden');
		}
		return false;
	});


	}else{
		if(value=="")
			alert("Debes Seleccionar un área");
		else
			alert("Ya has agregado ésta área");
		
	}

}


function dragAndDrop(type,id){
	$("#"+type+"_ul").sortable({ opacity: 0.6, cursor: 'move', update: function(){
		$("#"+type+"_ul > div > li").each(function(index){
			id=$(this).attr('rel');	
			$("#area_"+type+"_attributes_"+id+"_torder").val(index);
		});
	}
});

}
