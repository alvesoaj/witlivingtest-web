require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
    fixtures :products
    fixtures :users

    before :each do
        sign_in users(:one)
    end

    describe 'GET #index' do
        it 'populates an array of products' do
            get :index
            expect(assigns(:products)).not_to eq(nil)
        end

        it 'renders the :index view' do
            get :index
            expect(response).to render_template(:index)
        end
    end
    
    describe 'GET #show' do
        it 'assigns the requested product to @product' do
            product = products(:one)
            get :show, params: { id: product }
            expect(assigns(:product)).to eq(product)
        end

        it 'renders the :show template' do
            product = Product.create({ name: 'Test Name', description: 'Description Test', price: 100, quantity: 3 })
            get :show, params: { id: product }
            expect(response).to render_template(:show)
        end
    end
    
    describe 'GET #new' do
        it 'renders the :new template' do
            get :new
            expect(response).to render_template(:new)
        end
    end

    describe 'GET #edit' do
        it 'assigns the requested product to @product' do
            product = products(:one)
            get :edit, params: { id: product }
            expect(assigns(:product)).to eq(product)
        end

        it 'renders the :edit template' do
            product = products(:one)
            get :edit, params: { id: product }
            expect(response).to render_template(:edit)
        end
    end
    
    describe 'POST #create' do
        context 'with valid attributes' do
            it 'saves the new product in the database' do
                expect {
                    post :create, params: { product: { name: 'Test Name', description: 'Description Test', price: 100, quantity: 3 } }
                }.to change(Product, :count).by(1)
            end

            it 'redirects to the show product' do
                post :create, params: { product: { name: 'Test Name', description: 'Description Test', price: 100, quantity: 3 } }
                expect(response).to redirect_to(Product.last)
            end
        end
        
        context 'with invalid attributes' do
            it 'does not save the new product in the database' do
                expect {
                    post :create, params: { product: { name: 'Test Name', price: -100, quantity: 3 } }
                }.to_not change(Product, :count)
            end

            it 're-renders the :new template' do
                post :create, params: { product: { name: 'Test Name', price: -100, quantity: 3 } }
                expect(response).to render_template(:new)
            end
        end
    end

    describe 'PUT update' do
        before :each do
            @product = products(:one)
        end
      
        context 'valid attributes' do
            it 'located the requested @product' do
                put :update, params: { id: @product, product: { name: @product.name } }
                expect(assigns(:product)).to eq(@product)
            end
          
            it 'changes @product\'s attributes' do
                put :update, params: { id: @product, product: { name: 'New Product Name' } }
                @product.reload
                expect(@product.name).to eq('New Product Name')
            end
          
            it 'redirects to the updated product' do
                put :update, params: { id: @product, product: { name: 'New Product Name' } }
                expect(response).to redirect_to(@contact)
            end
        end
      
        context 'invalid attributes' do
            it 'locates the requested @product' do
                put :update, params: { id: @product, product: { price: -100 } }
                expect(assigns(:product)).to eq(@product)
            end
            
            it 'does not change @product\'s attributes' do
                put :update, params: { id: @product, product: { price: -100 } }
                expect(@product.name).to_not eq(-100)
            end
            
            it 're-renders the edit method' do
                put :update, params: { id: @product, product: { price: -100 } }
                expect(response).to render_template(:edit)
            end
        end
    end

    describe 'DELETE destroy' do
        before :each do
            @product = products(:one)
        end
      
        it 'deletes the product' do
            expect {
                delete :destroy, params: { id: @product }
            }.to change(Product,:count).by(-1)
        end
        
        it 'redirects to contacts#index' do
            delete :destroy, params: { id: @product }
            expect(response).to redirect_to(products_url)
        end
    end
end