
$(document).ready(function() {
	$('#pointer_init_date').dateinput({ format: 'yyyy/mm/dd'});

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






}

);


//Google charts
google.load('visualization', '1', {packages: ['corechart']});


google.setOnLoadCallback(drawVisualization);


function drawVisualization() {
	// Some raw data (not necessarily accurate)
	var data = google.visualization.arrayToDataTable([
		['Mes', 'Resultado del Periodo','Meta del Periodo'],
		['Ene', 800, 938],
		['Feb', 1000, 1120],
		['Mar', 1200, 1167],
		['Abr', 990, 1110],
		['May', 800, 691],
		['Jun', 1000, 1510],
		['Jul', 1500, 1410],
		['Ago', 1600, 1810],
		['Sep', 1800, 2010],
		['Oct', 1700, 1910],
		['Nov', 1550, 1510],
		['Dic', 1025, 1310],
		]);

		var options = {
			titlePosition: 'in',
			title : 'Simulacion de Indicadores',
			vAxis: {title: "Valor"},
			hAxis: {title: "Meses"},
			seriesType: "bars",
			series: {1: {type: "line"}}
		};

		var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
		chart.draw(data, options);
	}