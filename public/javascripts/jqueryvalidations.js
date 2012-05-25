$(document).ready(function(){
	
	// initialize validator with the new effect
$(".validation").validator({
   effect: 'wall',
   container: '#errors',
   lang: 'es',
   // do not validate inputs when they are edited
   errorInputEvent: null
 
// custom form submission logic
}).submit(function(e)  {
 
   // when data is valid
   if (!e.isDefaultPrevented()) {
 
      // tell user that everything is OK
      $("#errors").html("<h2>Correcto!</h2>");
 
      // prevent the form data being submitted to the server
      //e.preventDefault();
   }
 
});


});




$.tools.validator.fn("[minlength]", function(input, value) {
    var min = input.attr("minlength");
 
    return value.length >= min ? true : {
    es: "Ingresar  por lo menos  " +min+ " caracter" + (min > 1 ? "es" : "")
    };
    });

$.tools.validator.addEffect("wall", function(errors, event) {
 
	// get the message wall
	var wall = $(this.getConf().container).fadeIn();
 
	// remove all existing messages
	wall.find("p").remove();
 
	// add new ones
	$("#errors").html("<h2>Hemos encontrado errores!</h2><br/>");
	$.each(errors, function(index, error) {
		wall.append(
			"<p><strong>" +error.input.attr("rel")+ "</strong> : " +error.messages[0]+ "</p>"
		);
	});
 
// the effect does nothing when all inputs are valid
}, function(inputs)  {
 
});

// supply the language
$.tools.validator.localize("es", {
	'*'			: 'Virheellinen arvo',
	':email'  	: 'El Email es inválido',
	':number' 	: 'Numero inválido',
	':url' 		: 'La Url es inválida',
	'[max]'	 	: 'Ingresa un valor menor a  $1',
	'[min]'		: 'Ingresa un valor mayor a  $1',
	'[required]'	: 'No puede quedar en blanco'
});