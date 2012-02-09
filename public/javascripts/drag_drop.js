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

	$("#"+type+"_ul").sortable({ opacity: 0.6, cursor: 'move', update: function(){
			str="";
			$("#"+type+"_ul li").each(function(index){		
				str+=$(this).attr('rel');
				str+=',';
			});
			$.ajax({
  				type: 'POST',
  				url: '/'+controller+'/order?or='+str,
				success: function(data) {
   						$(".messages").html('<p id="notice" class="flash centered">El Orden se guardó correctamente</p>');
 						}
			});
	}
});



}