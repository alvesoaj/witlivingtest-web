class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :check_cart_section

    protected
        def check_cart_section
            # session expires 2 days before
            if session[:cart].present?
                if ((Time.current.to_time - JSON.parse(session[:cart])['create_at'].to_time) / 60) > 2880.0 # 34h * 60min in each
                    session[:cart] = nil;
                end
            end

            if session[:cart].nil?
                session[:cart] = {
                    id: SecureRandom.uuid,
                    create_at: Time.current,
                    products: [
                        { id: 2, quantity: 2, price: 25.0 },
                        { id: 5, quantity: 500, price: 15.0 }
                    ]
                }.to_json
            end
        end

        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :remember_me) }
            devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:login, :name, :email, :password, :remember_me) }
            devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password) }
        end
end
