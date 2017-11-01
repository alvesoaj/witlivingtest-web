require 'rails_helper'

RSpec.describe Product, type: :model do
    it 'is valid with valid attributes' do
        product = Product.new(name: 'Test Name', description: 'Test Description', price: 10.0, quantity: 1)
        expect(product).to be_valid
    end

    it 'is not valid without a name' do
        product = Product.new(description: 'Test Description', price: 10.0, quantity: 1)
        expect(product).not_to be_valid
    end

    it 'is not valid without a description' do
        product = Product.new(name: 'Test Name', price: 10.0, quantity: 1)
        expect(product).not_to be_valid
    end

    it 'is price greather than 0' do
        product = Product.new(name: 'Test Name', description: 'Test Description', price: -1, quantity: 1)
        expect(product).not_to be_valid
    end

    it 'is quantity greather than 0' do
        product = Product.new(name: 'Test Name', description: 'Test Description', price: 10.0, quantity: -1)
        expect(product).not_to be_valid
    end
end