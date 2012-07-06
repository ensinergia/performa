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