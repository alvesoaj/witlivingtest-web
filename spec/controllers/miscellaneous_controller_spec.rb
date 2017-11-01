require 'rails_helper'

RSpec.describe MiscellaneousController, type: :controller do
    fixtures :products

    describe 'GET #home' do
        it 'populates an array of products' do
            get :home
            expect(assigns(:products)).not_to eq(nil)
        end

        it 'renders the :home view' do
            get :home
            expect(response).to render_template(:home)
        end

        it 'has a session cart variable' do
            get :home
            expect(session[:cart]).not_to eq(nil)
        end

        it 'test if old session, than 2 days, expires' do
            product_one = products(:one)
            product_two = products(:two)
            
            session[:cart] = {
                id: SecureRandom.uuid,
                create_at: (Time.current - 24.days), # 2.days
                products: [
                    { id: product_one.id, quantity: 1, price: 25.0 },
                    { id: product_two.id, quantity: 1, price: 15.0 }
                ]
            }.to_json

            get :home
            expect(JSON.parse(session[:cart])['products'].size).to eq(0)
        end
    end
    
    describe 'GET #cart' do
        it 'populates an array of products' do
            get :cart
            expect(assigns(:products)).not_to eq(nil)
        end

        it 'renders the :cart view' do
            get :cart
            expect(response).to render_template(:cart)
        end

        it 'has a session cart variable' do
            get :cart
            expect(session[:cart]).not_to eq(nil)
        end
    end
end