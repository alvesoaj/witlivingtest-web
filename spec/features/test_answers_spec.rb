require 'rails_helper'

RSpec.feature 'Test Answers', type: :feature do
    fixtures :products

    scenario 'response all answered questions' do
        skip
        
        visit '/'

        product = products(:one)

        click_button "js-add1ToCart-#{product.id}"
        click_button "js-add1ToCart-#{product.id}"
        click_button "js-add1ToCart-#{product.id}"

        expect(page).to have_text('📚 3 | $30.00')
    end
end