# frozen_string_literal: true

# spec testing for our search feature

require 'rails_helper'
require 'faker'

RSpec.describe 'Tests search features and the existence of users' do
  it 'Shows that a user is created and on the index show page' do
    test_user = Faker::Omniauth.google
    User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'User'))
    # test_user = OmniAuth.config.mock_auth[:google_oauth2]

    visit '/'
    click_link 'Sign in'
    sleep 0.5
    click_link 'User Index page'
    expect(page).to have_content('List of all current users')
    expect(page).to have_content('Total Approved Hours:')
    expect(page).to have_content('Total Unapproved Hours:')
    expect(page).to have_content('User Role:')
    expect(page).to have_content('Lucas Campbell')
    # used lucas's name as default since it is being created thus easy to check if it is there
    # creating a random user in this process.
  end

  it 'Searches for a user that exists currently and will visit their respective profile page' do
    test_user = Faker::Omniauth.google
    User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'User'))
    test_user = OmniAuth.config.mock_auth[:google_oauth2]

    visit '/'
    click_link 'Sign in'
    click_link 'User Index page'
    click_link 'Search'
    fill_in 'Search', with: test_user[:info][:name]
    click_button('Search')
    expect(page).to have_content(test_user[:info][:name])
    click_link test_user[:info][:name]

    expect(page).to have_content(test_user[:info][:name])
    expect(page).to have_content('Total Approved Hours:')
    expect(page).to have_content('Total Unapproved Hours:')
    expect(page).to have_content('User Role:')
  end

  it 'Searches for a user that does not exist currently' do
    test_user = Faker::Omniauth.google
    User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'User'))
    # test_user = OmniAuth.config.mock_auth[:google_oauth2]

    visit '/'
    click_link 'Sign in'
    click_link 'User Index page'
    click_link 'Search'
    fill_in 'Search', with: 'test user'
    click_button('Search')
    expect(page).to have_content('test user not found')
  end
end
