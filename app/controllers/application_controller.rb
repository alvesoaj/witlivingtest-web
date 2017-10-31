class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :check_cart_section

    protected
        def check_cart_section
            if session[:cart].nil?
                session[:cart] = '{ "id": "' + SecureRandom.uuid + '", "products": [ { "id": 2, "quantity": 2, "price": 25.0 }, { "id": 5, "quantity": 500, "price": 15.0 }] }'
            end
        end

        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :remember_me) }
            devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:login, :name, :email, :password, :remember_me) }
            devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password) }
        end
end
