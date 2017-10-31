class MiscellaneousController < ApplicationController
    def home
        @products = Product.all.sample(6)
    end

    def cart
        @products = Product.where(id: JSON.parse(session[:cart])['products'].map { |p| p['id'] })
    end
end