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
	$("#errors").html("<h2>Hemos encontrado algunos errores!</h2><hr/>");
	$.each(errors, function(index, error) {
		wall.append(
			"<p><strong>" +error.input.attr("rel")+ "</strong> : " +error.messages[0]+ "</p>"
		);
	});
	$('html, body').animate({ scrollTop: 0 }, 'slow');
 
// the effect does nothing when all inputs are valid
}, function(inputs)  {
 
});

   $.tools.validator.fn("[data-equals]", "La contraseña no coincide", function(input) {
    var name = input.attr("data-equals"),
    field = $("#"+name);
    return input.val() == field.val() ? true : [name];
    });
  
  // Regular Expression to test whether the value is valid
    $.tools.validator.fn("[type=time]", "Propociona una fecha válida", function(input, value) {
    return /^\d\d:\d\d$/.test(value);
    });
  


// supply the language
$.tools.validator.localize("es", {
	'*'			: 'Corregir',
	':email'  	: 'El Email es inválido',
	':number' 	: 'Numero inválido',
	':url' 		: 'La Url es inválida',
	'[max]'	 	: 'Ingresa un valor menor a  $1',
	'[min]'		: 'Ingresa un valor mayor a  $1',
	'[required]'	: 'No puede estar vacio',
	'[data-equals]'	: 'Las contraseñas no coinciden'
});

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
