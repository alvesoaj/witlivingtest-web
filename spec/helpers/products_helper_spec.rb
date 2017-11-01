require 'spec_helper'

RSpec.describe ProductsHelper, type: :helper do
    fixtures :products

    before :each do
        product_one = products(:one)
        product_two = products(:two)
        
        session[:cart] = {
            id: SecureRandom.uuid,
            create_at: Time.current,
            products: [
                { id: product_one.id, quantity: 2, price: 25.0 },
                { id: product_two.id, quantity: 500, price: 15.0 }
            ]
        }.to_json
    end

    describe "#check_price" do
        it "returns not nil" do
            expect(helper.check_price(products(:one))).not_to eq(nil)
        end
    end
end