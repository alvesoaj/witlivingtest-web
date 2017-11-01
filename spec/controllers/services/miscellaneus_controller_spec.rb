require 'rails_helper'

RSpec.describe Services::MiscellaneousController, type: :controller do
    fixtures :products

    before :each do
        product_one = products(:one)
        product_two = products(:two)
        
        session[:cart] = {
            id: SecureRandom.uuid,
            create_at: Time.current,
            products: [
                { id: product_one.id, quantity: 1, price: 25.0 },
                { id: product_two.id, quantity: 1, price: 15.0 }
            ]
        }.to_json
    end

    describe 'GET #add_one_to_cart' do
        it 'add a new product into cart' do
            get :add_one_to_cart, params: { product_id: products(:three) }
            expect(JSON.parse(session[:cart])['products'].size).to eq(3)
        end
    end

    describe 'GET #rmv_one_from_cart' do
        it 'rmv one product from cart' do
            get :rmv_one_from_cart, params: { product_id: products(:one) }
            expect(JSON.parse(session[:cart])['products'].size).to eq(1)
        end
    end

    describe 'GET #rmv_product_from_cart' do
        it 'rmv one product from cart' do
            get :rmv_product_from_cart, params: { product_id: products(:one) }
            expect(JSON.parse(session[:cart])['products'].size).to eq(1)
        end
    end

    describe 'GET #upd_product_from_cart' do
        it 'update quantity from a product' do
            get :upd_product_from_cart, params: { product_id: products(:one), quantity: 3 }
            expect(JSON.parse(session[:cart])['products'].first['quantity']).to eq(3)
        end
    end

    describe 'GET #clear_cart' do
        it 'remove all products form cart' do
            get :clear_cart
            expect(JSON.parse(session[:cart])['products'].size).to eq(0)
        end
    end

    describe 'GET #pay' do
        it 'update product with payout' do
            product = products(:one)
            get :pay
            product.reload
            expect(product.quantity).to eq(8)
        end
    end
end