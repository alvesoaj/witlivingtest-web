function manageMainCart() {
    // Funtion to print cart quantity and total price
    if (window.cart['products'].length > 0) {
        var cartQuantity = 0;
        var cartPrice = 0;
        for (var i = 0; i < window.cart['products'].length; i++) {
            var product = window.cart['products'][i];
            cartQuantity += product['quantity'];
            cartPrice += product['quantity'] * product['price'];
            jQuery('#js-add1ToCart-' + product['id']).tooltip({ placement: 'bottom', title: product['quantity'], trigger: 'manual' }).tooltip('show');
        }
        jQuery('#js-cart').tooltip({ placement: 'top', title: '📚 ' + cartQuantity + ' | €' + cartPrice, trigger: 'manual' }).tooltip('show');
    }
}

document.addEventListener('turbolinks:load', function() {
    jQuery('.js-add1ToCart').on('click', function(event) {
        var jqxhr = $.getJSON('/services/miscellaneous/add_one_to_cart/' + jQuery(this).attr('data-product-id'), function() {
            window.cart = JSON.parse('<%= escape_javascript(session[:cart].html_safe) %>');
        }).fail(function() {
            console.log('error');
        });
    });
    manageMainCart();
    jQuery('.js-tooltips').tooltip('show'); 
});