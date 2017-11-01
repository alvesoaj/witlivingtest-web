Rails.application.routes.draw do
    devise_for :users
    
    root to: 'miscellaneous#home'

    get '/cart' => 'miscellaneous#cart', as: :cart

    resources :products
    resources :users

    namespace :services do
        get 'miscellaneous/add_one_to_cart/:product_id' => 'miscellaneous#add_one_to_cart'
        get 'miscellaneous/rmv_one_from_cart/:product_id' => 'miscellaneous#rmv_one_from_cart'
        get 'miscellaneous/rmv_product_from_cart/:product_id' => 'miscellaneous#rmv_product_from_cart'
        get 'miscellaneous/upd_product_from_cart/:product_id/:quantity' => 'miscellaneous#upd_product_from_cart'
        get 'miscellaneous/clear_cart' => 'miscellaneous#clear_cart'
        get 'miscellaneous/pay' => 'miscellaneous#pay'
    end
end