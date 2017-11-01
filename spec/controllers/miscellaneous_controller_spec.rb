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