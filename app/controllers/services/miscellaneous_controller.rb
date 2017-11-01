class Services::MiscellaneousController < ApplicationController
    def add_one_to_cart
        product = Product.find(params[:product_id])
        s_products = []
        hit = false
        h_session = JSON.parse(session[:cart])
        h_session['products'].each do |s_product|
            if s_product['id'] == product.id
                s_product['quantity'] += 1
                hit = true
            end
            s_products << s_product
        end

        if hit == false
            s_products << { id: product.id, quantity: 1, price: product.price }
        end

        h_session['products'] = s_products

        session[:cart] = h_session.to_json
        session[:create_at] = Time.current

        render json: h_session
    end

    def rmv_one_from_cart
        product = Product.find(params[:product_id])
        s_products = []
        h_session = JSON.parse(session[:cart])
        h_session['products'].each do |s_product|
            if s_product['id'] == product.id
                s_product['quantity'] -= 1
                hit = true
            end
            # Only re-add if amout is grether then 0
            if s_product['quantity'] > 0
                s_products << s_product
            end
        end

        h_session['products'] = s_products

        session[:cart] = h_session.to_json
        session[:create_at] = Time.current

        render json: h_session
    end

    def rmv_product_from_cart
        product = Product.find(params[:product_id])
        s_products = []
        h_session = JSON.parse(session[:cart])
        h_session['products'].each do |s_product|
            if s_product['id'] != product.id
                s_products << s_product
            end
        end

        h_session['products'] = s_products

        session[:cart] = h_session.to_json
        session[:create_at] = Time.current

        render json: h_session
    end

    def upd_product_from_cart
        product = Product.find(params[:product_id])
        s_products = []
        h_session = JSON.parse(session[:cart])
        h_session['products'].each do |s_product|
            if s_product['id'] == product.id
                s_product['price'] = product.price
                s_product['quantity'] = (params[:quantity].to_i <= product.quantity ? params[:quantity].to_i : product.quantity)
            end
            # Only re-add if amout is grether then 0
            if s_product['quantity'] > 0
                s_products << s_product
            end
        end

        h_session['products'] = s_products

        session[:cart] = h_session.to_json
        session[:create_at] = Time.current

        render json: h_session
    end

    def clear_cart
        h_session = JSON.parse(session[:cart])

        h_session['products'] = []

        session[:cart] = h_session.to_json
        session[:create_at] = Time.current

        render json: h_session
    end

    def pay
        h_session = JSON.parse(session[:cart])
        
        h_session['products'].each do |s_product|
            product = Product.find(s_product['id'])
            product.update(quantity: product.quantity - s_product['quantity'])
        end
        
        h_session['products'] = []

        session[:cart] = h_session.to_json
        session[:create_at] = Time.current

        render json: h_session
    end
end