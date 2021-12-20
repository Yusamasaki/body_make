require 'rails_helper'

RSpec.describe 'Users', type: :system do
  scenario 'shows greeting' do
    visit root_path
  end
end