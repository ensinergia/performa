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
		
		input="<div class='"+classs+"' id='project_"+type+"_attributes_new_"+id+"_div'> <div class='left'><input type='text' size='40' name='project["+type+"_attributes][new_"+id+"][name]' id='project_"+type+"_attributes_new_"+id+"_name' class='no_edit_input ' value='"+value+"'></div>"+inp;
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
			id=$(this).attr('rel');
			$("#"+id).remove();
			return false;
		});

		

	}

}
