/* La siguiente función se utiliza para visualizar la imagen seleccionada en la
 página html donde se desea "cargar" utilizando un llamado "ajax"*/
function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $('#blah')
                    .attr('src', e.target.result)
                    .height(200);
        };
        reader.readAsDataURL(input.files[0]);
    }
}

function addCard(formulario) {
    var idProducto = formulario.querySelector('input[name="idProducto"]').value;
    var cantidad = formulario.querySelector('select[name="cantidad"]').value;

    if (!idProducto || !cantidad) {
        alert("Por favor, selecciona un producto y una cantidad.");
        return;
    }

    var url = '/carrito/agregar/' + idProducto + '/' + cantidad;

    $.ajax({
        url: url,
        type: 'GET',
        success: function(response) {
            $("#resultsBlock").html(response);
            // Actualizar contador o hacer otras acciones aquí si quieres
        },
        error: function() {
            alert("Error al agregar el producto al carrito. Por favor, intenta de nuevo.");
        }
    });
}


// Ejemplo de una posible función para actualizar el contador.
// Debes adaptarla a la estructura de tu HTML.
function actualizarContadorCarrito(cantidadTotal) {
    $('#icono-carrito').text(cantidadTotal);
}