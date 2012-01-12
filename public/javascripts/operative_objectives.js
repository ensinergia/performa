$(document).ready(function() {
	$('#operative_objective_init_date').dateinput({ format: 'yyyy/mm/dd'});
	$('#operative_objective_final_date').dateinput({ format: 'yyyy/mm/dd'});

	update_text();

	$('#operative_objective_results').keypress(
		function() {
			update_text();
		}
		);
		
		$('#operative_objective_actions').keypress(
			function() {
				update_text();
			}
			);	

}
	
);

function update_text(){

	if($('#operative_objective_results').val()!='' || $('#operative_objective_actions').val()!='' ){
		str=$('#operative_objective_results').val()+" "+$('#through').html()+" "+ $('#operative_objective_actions').val();
		$('#through_text').html(str);
		$('#through_text').addClass("notification-box");
	}
}



google.load('visualization', '1', {packages:['gauge']});
 
