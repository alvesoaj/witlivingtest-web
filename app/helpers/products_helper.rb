module ProductsHelper
    def check_price(product)
        if test_price(product)
            return "<span>#{t('unit')}#{product.price}</span>".html_safe
        else
            s_product = find_production_in_session(product.id)
            title = t('helpers.products.price_change', old_p: s_product['price'], new_p: product.price)
            return "<span class='js-tooltips' data-toggle='tooltip' data-placement='bottom' data-trigger='manual' data-html='true' title='#{title}'>#{t('unit')}#{product.price}</span>".html_safe
        end
    end

    def check_quantity(product)
        s_product = find_production_in_session(product.id)
        if test_quantity(product)
            return ("<input id='js-updCartInp-" + product.id.to_s + "' class='js-updCartInp' type='text' value='#{s_product['quantity']}' data-product-id='" + product.id.to_s + "'>").html_safe
        else
            title = t('helpers.products.quantity_change', old_q: s_product['quantity'], new_q: product.quantity)
            return ("<input id='js-updCartInp-" + product.id.to_s + "' class='js-tooltips js-updCartInp' type='text' value='#{product.quantity}' data-toggle='tooltip' data-placement='bottom' data-trigger='manual' data-html='true' title='#{title}' data-product-id='" + product.id.to_s + "'>").html_safe
        end
    end

    def check_total(product)
        if test_quantity(product)
            return "#{t('unit')}#{(find_production_in_session(product.id)['quantity'] * product.price).round(2)}".html_safe
        else
            return "#{t('unit')}#{(product.quantity * product.price).round(2)}".html_safe
        end
    end

    def check_cart_total(products)
        total = 0.0
        products.each do |product|
            if test_quantity(product)
                total += find_production_in_session(product.id)['quantity'] * product.price
            else
                total += product.quantity * product.price
            end
        end
        return total.round(2)
    end

    protected
        def find_production_in_session(product_id)
            JSON.parse(session[:cart])['products'].each do |product|
                if product['id'] == product_id
                    return product
                end
            end
            return nil
        end

        def test_price(product)
            return product.price == find_production_in_session(product.id)['price'] ? true : false
        end

        def test_quantity(product)
            return product.quantity >= find_production_in_session(product.id)['quantity'] ? true : false
        end
end
