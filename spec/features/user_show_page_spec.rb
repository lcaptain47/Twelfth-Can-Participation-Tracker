# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User show page' do
  it 'Shows the users page link on the homepage and when clicked, goes to their page' do
    visit '/'
    click_link 'Sign in'
    expect(page).to have_content('Lucas Campbell')
    click_link('Lucas Campbell')
    expect(page).to have_content('Lucas Campbell')
    expect(page).to have_content('0.0')
    expect(page).to have_content('User')
  end
end
