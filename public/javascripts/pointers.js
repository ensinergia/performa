
$(document).ready(function() {
	
	$('#pointer_init_date').dateinput({ format: 'yyyy/mm/dd'});
	
	$("#pointer_periodicity").change(function(){updateGrid();});
	$("#pointer_advance_type").change(function(){updateGrid();});
	$("#pointer_init_date").change(function(){updateGrid();});
	
	

	$("#pointer_file").attr("size","15");

	$('#umb2').blur(
		function() {
			num=parseInt($('#umb2').val());
			if(num==100){
				$('#umb2').val(1)
				num=1;
			}

			$('#umb3').val(num+1);
		}
	);


	$('#umb4').blur(
		function() {
			num=parseInt($('#umb4').val());
			if(num==100){
				$('#umb4').val(parseInt($('#umb3').val())+1)
				num=parseInt($('#umb4').val());
			}

			$('#umb5').val(num+1);
		}
	);	


	$(":range").rangeinput();


		$('.delete').click(
				function() {
					id=$(this).attr('rel');
					remove='<input id="pointer_assets_attributes_new_'+id+'_destroy" class="hidden" type="text" value="1" name="pointer[assets_attributes]['+id+'][_destroy]">';
					$("#asset_destroy_"+id).append(remove);
					$("#asset_destroy_"+id).addClass('hidden');
					return false;
				}
			);




	$('#add_file').click(
		function() {
			inputs=$(".add_asset").length;
			id=Math.floor(Math.random()*1000);
			br="<br/>";
			div='<div id="asset_div_'+id+'">'+br+'<input id="asset_'+id+'" class="asset" size ="15" type="file" name="pointer[assets_attributes][new_'+id+'][asset]">';
			link='<a class="delete_attach" href="" rel="asset_div_'+id+'">[X]</div>'
			$("#files").append(div+link);



			$('.delete_attach').click(
				function() {
					id=$(this).attr('rel');
					$("#"+id).remove();
					return false;
				}
			);

			return false;
		}
	);



	$("#pointer_submit").click(function(){
		$(" .no_edit_input").removeAttr("disabled");
	});
	
	
	updateInputs();

});




function updateGrid(){
	conf=true;
	if($(".pinput").length>0)
		conf=confirm("Estas seguro de cambiar este campo?... Recuerda los datos ya capturados se perderán");
	if(conf){
		period=$("#pointer_periodicity").val();
		advance=$("#pointer_advance_type").val();
		init=$("#pointer_init_date").val();
	
		$.post('/pointers/upgradegrid/?period='+period+'&advance_type='+advance+'&init_date='+init,function(data) {
	  		$('#rows').html(data);
			updateInputs();
		});
	}
	
	
	
}

function updateInputs(){
		$(".pointer_input").blur(function(){
		a=$(".pinput");
		length=a.length;
		sumres=0;
		sumgoal=0;
		resant=0;
		goalant=0
		for(i=1; i<=length ; i++){
			goalval=parseFloat($("#pointer_goals_"+i).val());
			resval=parseFloat($("#pointer_results_"+i).val());
			
			if ($("#pointer_advance_type").val()!="Acumulado"){	
				sumgoal+=goalval;
				sumres+=resval;
			}else{
				sumgoal=goalval-goalant;
				sumres=resval-resant;
				
				goalant=goalval;
				resant=resval;		
			}	
					
			if(sumgoal!=NaN)
				$("#sumgoal_"+i).html(sumgoal);
			if(sumres!=NaN)	
				$("#sumres_"+i).html(sumres);
		}
		updateDataGraph();
	});
	
}

function updateDataGraph(){
	datagrid=[];
	months=new Array('Mes', 'Resultados','Metas');
	a=$(".pinput");
	length=a.length;
	
	for(i=length; i>0 ; i--){
		row=new Array($("#month_"+i).html(),parseFloat($("#pointer_results_"+i).val()),parseFloat($("#pointer_goals_"+i).val()));
		datagrid.unshift(row);
	}
	datagrid.unshift(months);
	drawVisualization();
}


function drawVisualization() {
	// Some raw data (not necessarily accurate)
	var data = google.visualization.arrayToDataTable(datagrid);

		var options = {
			titlePosition: 'in',
			title : 'Simulación de Indicadores',
			hAxis: {title: "Meses",textPosition: "out"},
			seriesType: "bars",
			series: {1: {type: "line"}}
		};

		var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
		chart.draw(data, options);
	}