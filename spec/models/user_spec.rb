require 'rails_helper'

RSpec.describe User, type: :model do
    it 'is valid with valid attributes' do
        user = User.new(email: 'test@email.com', password: '123456789', name: 'Test Name')
        expect(user).to be_valid
    end

    it 'is name greather than 3 chars' do
        user = User.new(name: 'X')
        expect(user).not_to be_valid
    end
end