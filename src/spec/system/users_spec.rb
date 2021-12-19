require 'rails_helper'

RSpec.describe 'Users', type: :system do
  scenario 'shows greeting' do
    visit root_path
    expect(page).to have_content 'Hello World!'
  end
end