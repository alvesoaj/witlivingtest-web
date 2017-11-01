function manageMainCart() {
    // Funtion to print cart quantity and total price
    if (window.cart['products'].length > 0) {
        var cartQuantity = 0;
        var cartPrice = 0;
        for (var i = 0; i < window.cart['products'].length; i++) {
            var product = window.cart['products'][i];
            cartQuantity += product['quantity'];
            cartPrice += product['quantity'] * product['price'];
            jQuery('#js-add1ToCart-' + product['id']).tooltip({ placement: 'bottom', title: product['quantity'], trigger: 'manual' });
        }
        jQuery('#js-cart').tooltip({ placement: 'top', title: '📚 ' + cartQuantity + ' | $' + cartPrice.toFixed(2), trigger: 'manual' });
    }
    jQuery('.js-tooltips').tooltip('show');
}

document.addEventListener('turbolinks:load', function() {
    // Event to add one book in cart
    jQuery('.js-add1ToCart').on('click', function(event) {
        jQuery('.js-tooltips').tooltip('destroy');
        jQuery.getJSON('/services/miscellaneous/add_one_to_cart/' + jQuery(this).attr('data-product-id'), function(data) {
            window.cart = data;
            setTimeout(function() {
                manageMainCart();
            }, 1000); // A delay to bootstrap tooltip
        }).fail(function() {
            console.log('error');
        });
    });
    // Event to rmv one book from the cart
    jQuery('.js-rmv1FromCart').on('click', function(event) {
        jQuery('.js-tooltips').tooltip('destroy');
        jQuery.getJSON('/services/miscellaneous/rmv_one_from_cart/' + jQuery(this).attr('data-product-id'), function(data) {
            window.cart = data;
            setTimeout(function() {
                manageMainCart();
            }, 1000); // A delay to bootstrap tooltip
        }).fail(function() {
            console.log('error');
        });
    });
    // Event to rmv all books from the cart
    jQuery('.js-rmvFromCart').on('click', function(event) {
        if (confirm('Are you sure?') == true) {
            jQuery.getJSON('/services/miscellaneous/rmv_product_from_cart/' + jQuery(this).attr('data-product-id'), function(data) {
                location.reload();
            }).fail(function() {
                console.log('error');
            });
        }
    });
    // Event to update a book quantity in the cart, by button
    jQuery('.js-updCartBtn').on('click', function(event) {
        var product_id = jQuery(this).attr('data-product-id');
        var quantity = jQuery('#js-updCartInp-' + product_id).val();
        jQuery.getJSON('/services/miscellaneous/upd_product_from_cart/' + product_id + '/' + quantity, function(data) {
            location.reload();
        }).fail(function() {
            console.log('error');
        });
    });
    // Event to update a book quantity in the cart, by input ENTER
    jQuery('.js-updCartInp').keyup(function(event) {
        if (event.which == 13 || event.keyCode == 13) { // ENTER
            var product_id = jQuery(this).attr('data-product-id');
            var quantity = jQuery(this).val();
            jQuery.getJSON('/services/miscellaneous/upd_product_from_cart/' + product_id + '/' + quantity, function(data) {
                location.reload();
            }).fail(function() {
                console.log('error');
            });
        }
    });
    // Event to rmv all books from the cart
    jQuery('#js-clrCart').on('click', function(event) {
        if (confirm('Are you sure?') == true) {
            jQuery.getJSON('/services/miscellaneous/clear_cart', function(data) {
                window.location.href = '/';
            }).fail(function() {
                console.log('error');
            });
        }
    });
    // Event to rmv all books from the cart
    jQuery('#js-pay').on('click', function(event) {
        if (confirm('Are you sure?') == true) {
            jQuery.getJSON('/services/miscellaneous/pay', function(data) {
                jQuery('#js-payoutModal').modal('show');
                setTimeout(function() {
                    window.location.href = '/';
                }, 5000);
            }).fail(function() {
                console.log('error');
            });
        }
    });
    // Always build tooltips
    manageMainCart();
});