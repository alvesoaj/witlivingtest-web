class MiscellaneousController < ApplicationController
    def home
        @products = Product.all.sample(6)
    end
end