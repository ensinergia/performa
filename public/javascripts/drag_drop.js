$(document).ready(function() {

	$('.head').unbind('click');
	$('.head').click(function() {	
		id=$(this).attr('rel');
		$("#"+id).toggle('slow');
		return false;
	});

	$(".collapse").toggle('slow');			

	dragAndDrop("drag","");

});



function dragAndDrop(type,id){

		$(".actions").hide();

		$("#"+type+"_ul li").each(function(index){		
				$(this).hover(function(){id=$(this).attr('rel');$("#actions_"+id).show();});
				$(this).mouseleave(function(){id=$(this).attr('rel');$("#actions_"+id).hide();});
			});
	


	$("#"+type+"_ul").sortable({ opacity: 0.6, cursor: 'move', update: function(){
			str="";
			$("#"+type+"_ul li").each(function(index){		
				id=$(this).attr('rel');
				str+=$(this).attr('rel');
				str+=',';
				$("#priority_"+id).html(index+1);
	
			});
			$.ajax({
  				type: 'POST',
  				url: '/'+controller+'/order?or='+str+"&model="+model,
				success: function(data) {
   						$(".messages").html('<p id="notice" class="flash centered">El Orden se guardó correctamente</p>');
 						}
			});
	}
	
	
	
	
});



}