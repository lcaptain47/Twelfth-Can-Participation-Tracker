# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Deletion feature' do
  it 'does not show the user delete button or system wipe for anyone who are not able to delete users' do
    test_user = Faker::Omniauth.google
    User.create(uid: test_user[:uid], full_name: 'Jane Doe', email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'User'))

    visit '/'
    click_link 'Sign in'
    click_link 'User Index Page'
    click_link 'Jane Doe'

    expect(page).not_to have_content('Delete User')
    expect(page).not_to have_content('System Wipe')

    click_link 'Homepage'
    click_link 'User Index Page'
    click_link 'Lucas Campbell'

    expect(page).not_to have_content('Delete User')
    expect(page).not_to have_content('System Wipe')
  end

  it 'shows the delete button on anyones page and does not show the sytem wipe button for anyone that can delete users' do
    test_user = Faker::Omniauth.google
    User.create(uid: test_user[:uid], full_name: 'Jane Doe', email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'Officer'))

    test_user = OmniAuth.config.mock_auth[:google_oauth2]
    User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'President'))

    visit '/'
    click_link 'Sign in'
    click_link 'User Index Page'
    expect(page).to have_content('Jane Doe')
    click_link 'Jane Doe'
    expect(page).to have_content('Delete User')
    expect(page).not_to have_content('System Wipe')
  end

  it 'shows the system wipe on their own page and does not show the user delete button for anyone that can delete users' do
    test_user = OmniAuth.config.mock_auth[:google_oauth2]
    User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'President'))

    visit '/'
    click_link 'Sign in'
    click_link test_user[:info][:name]

    expect(page).not_to have_content('Delete User')
    expect(page).to have_content('System Wipe')
  end

  it 'Deletes the user when the delete user button is clicked' do
    test_user = OmniAuth.config.mock_auth[:google_oauth2]
    User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'President'))

    test_user = Faker::Omniauth.google
    User.create(uid: test_user[:uid], full_name: 'Tony Stark', email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'User'))

    visit '/'
    click_link 'Sign in'
    click_link 'User Index Page'
    expect(page).to have_content('Tony Stark')
    click_link 'Tony Stark'
    expect(page).to have_content('Delete User')
    expect(page).not_to have_content('System Wipe')

    page.accept_confirm do
      click_link 'Delete User'
    end

    click_link 'User Index Page'
    expect(page).not_to have_content('Tony Stark')
  end

  it 'Deletes all regular users when the system wipe buttton is clicked' do
    test_user = OmniAuth.config.mock_auth[:google_oauth2]
    User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'President'))

    test_user = Faker::Omniauth.google
    User.create(uid: test_user[:uid], full_name: 'Tony Stark', email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'User'))

    visit '/'
    click_link 'Sign in'

    click_link 'Lucas Campbell'

    expect(page).not_to have_content('Delete User')
    expect(page).to have_content('System Wipe')

    page.accept_confirm do
      click_link 'System Wipe'
    end

    click_link 'User Index Page'
    expect(page).not_to have_content('Tony Stark')
  end
end
