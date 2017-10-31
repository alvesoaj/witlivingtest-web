require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    fixtures :users

    describe 'GET #index' do
        it 'populates an array of users' do
            get :index
            expect(assigns(:users)).to eq(User.all)
        end

        it 'renders the :index view' do
            get :index
            expect(response).to render_template(:index)
        end
    end
    
    describe 'GET #show' do
        it 'assigns the requested user to @user' do
            user = users(:one)
            get :show, params: { id: user }
            expect(assigns(:user)).to eq(user)
        end

        it 'renders the :show template' do
            user = User.create({ name: 'Test Name', email: 'user@email.com', password: '123456789' })
            get :show, params: { id: user }
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
        it 'assigns the requested user to @user' do
            user = users(:one)
            get :edit, params: { id: user }
            expect(assigns(:user)).to eq(user)
        end

        it 'renders the :edit template' do
            user = users(:one)
            get :edit, params: { id: user }
            expect(response).to render_template(:edit)
        end
    end
    
    describe 'POST #create' do
        context 'with valid attributes' do
            it 'saves the new user in the database' do
                expect {
                    post :create, params: { user: { name: 'Test Name', email: 'user@email.com', password: '123456789' } }
                }.to change(User, :count).by(1)
            end

            it 'redirects to the show user' do
                post :create, params: { user: { name: 'Test Name', email: 'user@email.com', password: '123456789' } }
                expect(response).to redirect_to(User.last)
            end
        end
        
        context 'with invalid attributes' do
            it 'does not save the new user in the database' do
                expect {
                    post :create, params: { user: { name: 'XX' } }
                }.to_not change(User, :count)
            end

            it 're-renders the :new template' do
                post :create, params: { user: { name: 'XX' } }
                expect(response).to render_template(:new)
            end
        end
    end

    describe 'PUT update' do
        before :each do
            @user = users(:one)
        end
      
        context 'valid attributes' do
            it 'located the requested @user' do
                put :update, params: { id: @user, user: { name: @user.name } }
                expect(assigns(:user)).to eq(@user)
            end
          
            it 'changes @user\'s attributes' do
                put :update, params: { id: @user, user: { name: 'New User Name' } }
                @user.reload
                expect(@user.name).to eq('New User Name')
            end
          
            it 'redirects to the updated user' do
                put :update, params: { id: @user, user: { name: 'New User Name' } }
                expect(response).to redirect_to(@contact)
            end
        end
      
        context 'invalid attributes' do
            it 'locates the requested @user' do
                put :update, params: { id: @user, user: { name: 'XX' } }
                expect(assigns(:user)).to eq(@user)
            end
            
            it 'does not change @user\'s attributes' do
                put :update, params: { id: @user, user: { name: 'XX' } }
                expect(@user.name).to_not eq('XX')
            end
            
            it 're-renders the edit method' do
                put :update, params: { id: @user, user: { name: 'XX' } }
                expect(response).to render_template(:edit)
            end
        end
    end

    describe 'DELETE destroy' do
        before :each do
            @user = users(:one)
        end
      
        it 'deletes the user' do
            expect {
                delete :destroy, params: { id: @user }
            }.to change(User,:count).by(-1)
        end
        
        it 'redirects to contacts#index' do
            delete :destroy, params: { id: @user }
            expect(response).to redirect_to(users_url)
        end
    end
end