


$(document).ready(function() {

	//Initializers
	$('.head').unbind('click');
	$('.head').click(function() {	
		id=$(this).attr('rel');
		$("#"+id).toggle('slow');
		return false;
	});
	$("#pointer_file").attr("size","15");
	$('#pointer_init_date').dateinput({ format: 'yyyy/mm/dd'});

	$("#pointer_periodicity").change(function(){updateGrid();});
	$("#pointer_advance_type").change(function(){updateGrid();});
	$("#pointer_init_date").change(function(){updateGrid();});


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

	$("#pointer_behavior").change(function (){updateThresholds(); 	updateGauge(); });

});


google.load('visualization', '1', {packages:['gauge']});



//Funtions 


function secondThrehold(){

	behavior=$("#pointer_behavior").val();
	if (behavior=="Ascendente" || behavior=="" ){
		num=parseInt($('#umb2').val());
		if(num==100 || num<=$('#umb1').val()){
			$('#umb2').val(1);
			num=1;
		}

		$('#umb3').val(num+1);
		thirdThrehold();

	}else{
		num=parseInt($('#umb2').val());
		if(num== 0 || num>=$('#umb1').val()){
			$('#umb2').val(99);
			num=99;
		}

		$('#umb3').val(num-1);
		thirdThrehold();
	}		

	updateGauge();

}


function thirdThrehold(){
	behavior=$("#pointer_behavior").val();
	if (behavior=="Ascendente" || behavior=="" ){
		num=parseInt($('#umb3').val());
		if(num<=$('#umb2').val()){
			$('#umb3').val($('#umb2').val()+1)

		}
		num=parseInt($('#umb3').val());
		if(num>=$('#umb4').val()){
			$('#umb4').val(num+1);
			fourthThehold();
		}

	}else{
		num=parseInt($('#umb3').val());
		if(num>=$('#umb2').val()){
			$('#umb3').val($('#umb2').val()-1)

		}

		num=parseInt($('#umb3').val());
		if(num<=$('#umb4').val()){
			$('#umb4').val(num-1);
			fourthThehold();
		}

	}		
	updateGauge();
}



function fourthThehold(){
	behavior=$("#pointer_behavior").val();
	if (behavior=="Ascendente" || behavior=="" ){
		num=parseInt($('#umb4').val());
		if(num==100  || num<=$('#umb3').val()){
			$('#umb4').val(parseInt($('#umb3').val())+1)
			num=parseInt($('#umb4').val());
		}

		$('#umb5').val(num+1);
	}else{
		num=parseInt($('#umb4').val());
		if(num==0  || num>=$('#umb3').val()){
			$('#umb4').val(parseInt($('#umb3').val())-1)
			num=parseInt($('#umb4').val());
		}

		$('#umb5').val(num-1);

	}	
	updateGauge();
}

//  its  a  mess  ,  i need  to  fix  it  out 

function updateThresholds(){
	$('#umb2').unbind('blur');
	$('#umb4').unbind('blur');

	behavior=$("#pointer_behavior").val();
	if (behavior=="Ascendente" || behavior=="" ){

		$('#umb1').val(0);
		$('#umb6').val(100);
		$('#umb2').val(1);
		$('#umb4').val(4);
		$('#umb2').blur(function (){secondThrehold()});
		$('#umb4').blur(function (){fourthThehold()});	

	}else{

		$('#umb1').val(100);
		$('#umb2').val(99);
		$('#umb3').val(98);
		$('#umb4').val(97);
		$('#umb5').val(96);
		$('#umb6').val(0);
		$('#umb2').blur(function (){secondThrehold()});
		$('#umb4').blur(function (){fourthThehold()});	

	}	
}


function updateGrid(){
	conf=true;
	if($(".pinput").length>0)
	conf=confirm("Estas seguro de cambiar este campo?... Recuerda los datos ya capturados se perderán");
	if(conf){
		period=$("#pointer_periodicity").val();
		advance=$("#pointer_advance_type").val();
		init=$("#pointer_init_date").val();
		$("#collapse_graph").show();
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

			if(!isNaN(sumgoal))
			$("#sumgoal_"+i).html(sumgoal);
			if(!isNaN(sumres))	
			$("#sumres_"+i).html(sumres);
		}

		updateDataGraph();
		getStatus();

	});
	updateDataGraph();
}

function updateDataGraph(){
	$("#collapse_graph").show();		
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
	if($("#pointer_init_date").val()==""){
		$("#collapse_graph").toggle();
	}

}


function getStatus(){
	a=$(".pinput");
	length=a.length;
	globalres=0;
	globalgoal=0;
	advance=0;
	for(i=1; i<=length ; i++){
		goalval=parseFloat($("#pointer_goals_"+i).val());
		resval=parseFloat($("#pointer_results_"+i).val());

		if(!isNaN(resval)){
			globalres+=resval;
			advance+=1;
		}
		if(!isNaN(goalval))	
		globalgoal+=goalval;

	}

	status=(globalres*100)/globalgoal;
	status=Math.round(status*100)/100;
	status=status.toFixed(2);

	advance=(advance*100)/12;
	advance=Math.round(advance*100)/100;
	advance=advance.toFixed(2);

	$("#pointer_status").val(status);
	$("#pointer_advance").val(advance);
	updateGauge();
}


function updateGauge(){
	behavior=$("#pointer_behavior").val();
	advance=parseFloat($('#pointer_status').val());
	umb2=parseFloat($('#umb2').val());
	umb4=parseFloat($('#umb4').val());
	if (isNaN(advance))
	advance=0;
	var data = new google.visualization.DataTable();
	data.addColumn('string', 'Label');
	data.addColumn('number', 'Value');
	data.addRows([
		['Status', advance]
		]);
		if (behavior=="Ascendente" || behavior=="" ){
			var options = {
				width: 450, height: 120,
				redFrom: 0, redTo: umb2,
				yellowFrom:umb2 + 1, yellowTo: umb4,
				greenFrom:umb4 + 1, greenTo:100,
				minorTicks: 5,
				max: 100,
				min: 0
			};		
		}else{
			var options = {
				width: 450, height: 120,
				redFrom: 100, redTo: umb2,
				yellowFrom:umb2 + 1, yellowTo: umb4,
				greenFrom:umb4 + 1, greenTo:0,
				minorTicks: 5, 
				max: 0,
				min: 100
			};
		}
		chart.draw(data, options);

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