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
            return "<input type='text' value='#{s_product['quantity']}'>".html_safe
        else
            title = t('helpers.products.quantity_change', old_q: s_product['quantity'], new_q: product.quantity)
            return "<input class='js-tooltips' type='text' value='#{product.quantity}' data-toggle='tooltip' data-placement='bottom' data-trigger='manual' data-html='true' title='#{title}' >".html_safe
        end
    end

    def check_total(product)
        if test_quantity(product)
            return "#{t('unit')}#{find_production_in_session(product.id)['quantity'].to_i * product.price}"
        else
            return "#{t('unit')}#{product.quantity * product.price}"
        end
    end

    def check_cart_total(products)
        total = 0.0
        products.each do |product|
            if test_quantity(product)
                total += find_production_in_session(product.id)['quantity'].to_i * product.price
            else
                total += product.quantity * product.price
            end
        end
        return total
    end

    protected
        def find_production_in_session(product_id)
            JSON.parse(session[:cart])['products'].each do |product|
                if product['id'].to_i == product_id.to_i
                    return product
                end
            end
            return nil
        end

        def test_price(product)
            return product.price.to_f == find_production_in_session(product.id)['price'].to_f ? true : false
        end

        def test_quantity(product)
            return product.quantity.to_i >= find_production_in_session(product.id)['quantity'].to_i ? true : false
        end
end
