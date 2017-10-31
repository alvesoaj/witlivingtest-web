Rails.application.routes.draw do
    devise_for :users
    
    root to: 'miscellaneous#home'

    get '/cart' => 'miscellaneous#cart', as: :cart

    resources :products
    resources :users
end