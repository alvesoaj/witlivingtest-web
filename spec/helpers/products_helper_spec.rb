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
                { id: product_one.id, quantity: 10, price: 10.0 },
                { id: product_two.id, quantity: 9, price: 15.0 }
            ]
        }.to_json
    end

    describe "#check_price" do
        it "returns not nil" do
            expect(helper.check_price(products(:one))).not_to eq(nil)
        end
    end

    describe "#check_quantity" do
        it "returns not nil" do
            expect(helper.check_quantity(products(:one))).not_to eq(nil)
        end
    end

    describe "#check_total" do
        it "returns not nil" do
            expect(helper.check_total(products(:one))).not_to eq(nil)
        end
    end

    describe "#check_cart_total" do
        it "returns not nil" do
            products = Product.where(id: JSON.parse(session[:cart])['products'].map { |p| p['id'] })
            expect(helper.check_cart_total(products)).not_to eq(nil)
        end
    end

    describe "#find_production_in_session" do
        it "with a valid id" do
            expect(helper.find_production_in_session(products(:one).id)).not_to eq(nil)
        end

        it "without a valid id" do
            expect(helper.find_production_in_session(products(:three).id)).to eq(nil)
        end
    end

    describe "#test_price" do
        it "with a valid id" do
            expect(helper.test_price(products(:one))).to eq(true)
        end

        it "without a valid id" do
            expect(helper.test_price(products(:two))).to eq(false)
        end
    end

    describe "#test_quantity" do
        it "with a valid id" do
            expect(helper.test_quantity(products(:one))).to eq(false)
        end

        it "without a valid id" do
            expect(helper.test_quantity(products(:two))).to eq(true)
        end
    end
end