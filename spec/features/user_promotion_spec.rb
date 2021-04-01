# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe 'Tests the user promotion feature' do
  it "reveals a promote to officer button if the president is on a normal user's show page" do
    Event.create(name: 'Test', date: '12-01-2021', volunteers: 1)
    test_user = Faker::Omniauth.google
    User.create(uid: test_user[:uid], full_name: 'John Doe', email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'User'))
    Timeslot.create(time: '12:00', duration: 60, event: Event.first, user: User.find_by(full_name: 'John Doe'), role: 'Volunteer', role_number: 1)

    test_user = OmniAuth.config.mock_auth[:google_oauth2]
    User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'President'))

    visit '/'
    click_link 'Sign in'
    click_link 'Test'
    expect(page).to have_content('John Doe')
    click_link 'John Doe'
    expect(page).to have_content('John Doe')
    expect(page).to have_link('Promote to Officer')
  end

  it "reveals a promote to president button and a demote to user button if the president is on an officer's show page" do
    Event.create(name: 'Test', date: '12-01-2021', volunteers: 1)
    test_user = Faker::Omniauth.google
    User.create(uid: test_user[:uid], full_name: 'John Doe', email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'Officer'))
    Timeslot.create(time: '12:00', duration: 60, event: Event.first, user: User.find_by(full_name: 'John Doe'), role: 'Volunteer', role_number: 1)

    test_user = OmniAuth.config.mock_auth[:google_oauth2]
    User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'President'))

    visit '/'
    click_link 'Sign in'
    click_link 'Test'
    expect(page).to have_content('John Doe')
    click_link 'John Doe'
    expect(page).to have_content('John Doe')
    expect(page).to have_link('Promote to President')
    expect(page).to have_link('Demote to User')
  end

  it "promotes a User to Officer and reloads the page if the president clicks the promote to officer button on the normal user's show page" do
    Event.create(name: 'Test', date: '12-01-2021', volunteers: 1)
    test_user = Faker::Omniauth.google
    User.create(uid: test_user[:uid], full_name: 'John Doe', email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'User'))
    Timeslot.create(time: '12:00', duration: 60, event: Event.first, user: User.find_by(full_name: 'John Doe'), role: 'Volunteer', role_number: 1)

    test_user = OmniAuth.config.mock_auth[:google_oauth2]
    User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'President'))

    visit '/'
    click_link 'Sign in'
    click_link 'Test'
    expect(page).to have_content('John Doe')
    click_link 'John Doe'
    expect(page).to have_content('John Doe')
    expect(page).to have_link('Promote to Officer')
    click_link 'Promote to Officer'
    sleep(1)
    expect(page).to have_content('User Role: Officer')
    expect(page).to have_link('Promote to President')
    expect(page).to have_link('Demote to User')
  end

  it "reveals a confirmation message, promotes the target user to president, and demotes the current president to a regular user if the current president clicks the promote to president button and then accepts the confirmation on the Officer's show page" do
    Event.create(name: 'Test', date: '12-01-2021', volunteers: 1)
    test_user = Faker::Omniauth.google
    User.create(uid: test_user[:uid], full_name: 'John Doe', email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'Officer'))
    Timeslot.create(time: '12:00', duration: 60, event: Event.first, user: User.find_by(full_name: 'John Doe'), role: 'Volunteer', role_number: 1)
    test_user = OmniAuth.config.mock_auth[:google_oauth2]
    User.create(uid: test_user[:uid], full_name: 'Chuck Bronson', email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'President'))
    visit '/'
    click_link 'Sign in'
    click_link 'Chuck Bronson'
    expect(page).to have_content('User Role: President')
    click_link 'Homepage'
    click_link 'Test'
    click_link 'John Doe'
    expect(page).to have_link('Promote to President')
    expect(page).to have_link('Demote to User')

    page.accept_confirm do
      click_link 'Promote to President'
    end
    sleep(1)
    expect(page).to have_content('User Role: President')

    click_link 'Homepage'
    expect(page).to have_link('Chuck Bronson')
    expect(page).not_to have_link('New Event')
    click_link 'Chuck Bronson'
    expect(page).to have_content('User Role: User')
  end

  it "reveals a confirmation message and closes it without making any changes if the current president clicks the promote to President button and then denies the confirmation on the Officer's show page" do
    Event.create(name: 'Test', date: '12-01-2021', volunteers: 1)
    test_user = Faker::Omniauth.google
    User.create(uid: test_user[:uid], full_name: 'John Doe', email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'Officer'))
    Timeslot.create(time: '12:00', duration: 60, event: Event.first, user: User.find_by(full_name: 'John Doe'), role: 'Volunteer', role_number: 1)

    test_user = OmniAuth.config.mock_auth[:google_oauth2]
    User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'President'))

    visit '/'
    click_link 'Sign in'
    click_link 'Test'
    expect(page).to have_content('John Doe')
    click_link 'John Doe'
    expect(page).to have_content('John Doe')
    expect(page).to have_link('Promote to President')
    expect(page).to have_link('Demote to User')

    page.dismiss_confirm do
      click_link 'Promote to President'
    end
    sleep(1)

    expect(page).to have_content('User Role: Officer')
    expect(page).to have_content('John Doe')
    expect(page).to have_link('Promote to President')
    expect(page).to have_link('Demote to User')
  end

  it "demotes an Officer to User and reloads the page if the president clicks the demote to user button on the Officer's show page" do
    Event.create(name: 'Test', date: '12-01-2021', volunteers: 1)
    test_user = Faker::Omniauth.google
    User.create(uid: test_user[:uid], full_name: 'John Doe', email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'Officer'))
    Timeslot.create(time: '12:00', duration: 60, event: Event.first, user: User.find_by(full_name: 'John Doe'), role: 'Volunteer', role_number: 1)

    test_user = OmniAuth.config.mock_auth[:google_oauth2]
    User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'President'))

    visit '/'
    click_link 'Sign in'
    click_link 'Test'
    expect(page).to have_content('John Doe')
    click_link 'John Doe'
    expect(page).to have_content('John Doe')
    expect(page).to have_link('Promote to President')
    expect(page).to have_link('Demote to User')

    click_link 'Demote to User'

    sleep(1)

    expect(page).to have_content('User Role: User')
    expect(page).to have_content('John Doe')
    expect(page).to have_link('Promote to Officer')
  end

  it "does not reveal any promotion buttons if a normal User is on another User's show page" do
    Event.create(name: 'Test', date: '12-01-2021', volunteers: 1)
    test_user = Faker::Omniauth.google
    User.create(uid: test_user[:uid], full_name: 'John Doe', email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'User'))
    Timeslot.create(time: '12:00', duration: 60, event: Event.first, user: User.find_by(full_name: 'John Doe'), role: 'Volunteer', role_number: 1)

    test_user = OmniAuth.config.mock_auth[:google_oauth2]
    User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'User'))

    visit '/'
    click_link 'Sign in'
    click_link 'Test'
    expect(page).to have_content('John Doe')
    click_link 'John Doe'
    expect(page).to have_content('John Doe')
    expect(page).to have_content('User Role: User')
    expect(page).not_to have_link('Promote to Officer')
    expect(page).not_to have_link('Promote to President')
    expect(page).not_to have_link('Demote to User')
  end

  it "does not reveal any promotion buttons if a normal User is on an Officer's show page" do
    Event.create(name: 'Test2', date: '12-01-2021', volunteers: 1)
    test_user = Faker::Omniauth.google
    User.create(uid: test_user[:uid], full_name: 'James Doe', email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'Officer'))
    Timeslot.create(time: '12:00', duration: 60, event: Event.find_by(name: 'Test2'), user: User.find_by(full_name: 'James Doe'), role: 'Volunteer', role_number: 1)

    test_user = OmniAuth.config.mock_auth[:google_oauth2]
    User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'User'))

    visit '/'
    click_link 'Sign in'
    click_link 'Test2'
    expect(page).to have_content('James Doe')
    click_link 'James Doe'
    expect(page).to have_content('James Doe')
    expect(page).to have_content('User Role: Officer')
    expect(page).not_to have_link('Promote to Officer')
    expect(page).not_to have_link('Promote to President')
    expect(page).not_to have_link('Demote to User')
  end

  it "does not reveal any promotion buttons if a normal User is on the President's show page" do
    Event.create(name: 'Test3', date: '12-01-2021', volunteers: 1)
    test_user = Faker::Omniauth.google
    User.create(uid: test_user[:uid], full_name: 'Jonathan Doe', email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'President'))
    Timeslot.create(time: '12:00', duration: 60, event: Event.find_by(name: 'Test3'), user: User.find_by(full_name: 'Jonathan Doe'), role: 'Volunteer', role_number: 1)

    test_user = OmniAuth.config.mock_auth[:google_oauth2]
    User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'User'))

    visit '/'
    click_link 'Sign in'
    click_link 'Test3'
    expect(page).to have_content('Jonathan Doe')
    click_link 'Jonathan Doe'
    expect(page).to have_content('Jonathan Doe')
    expect(page).to have_content('User Role: President')
    expect(page).not_to have_link('Promote to Officer')
    expect(page).not_to have_link('Promote to President')
    expect(page).not_to have_link('Demote to User')
  end

  it "does not reveal any promotion buttons if an Officer is on a normal User's show page" do
    Event.create(name: 'Test', date: '12-01-2021', volunteers: 1)
    test_user = Faker::Omniauth.google
    User.create(uid: test_user[:uid], full_name: 'John Doe', email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'User'))
    Timeslot.create(time: '12:00', duration: 60, event: Event.first, user: User.find_by(full_name: 'John Doe'), role: 'Volunteer', role_number: 1)

    test_user = OmniAuth.config.mock_auth[:google_oauth2]
    User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'Officer'))

    visit '/'
    click_link 'Sign in'
    click_link 'Test'
    expect(page).to have_content('John Doe')
    click_link 'John Doe'
    expect(page).to have_content('John Doe')
    expect(page).to have_content('User Role: User')
    expect(page).not_to have_link('Promote to Officer')
    expect(page).not_to have_link('Promote to President')
    expect(page).not_to have_link('Demote to User')
  end

  it "does not reveal any promotion buttons if an Officer is on another Officer's show page" do
    Event.create(name: 'Test2', date: '12-01-2021', volunteers: 1)
    test_user = Faker::Omniauth.google
    User.create(uid: test_user[:uid], full_name: 'James Doe', email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'Officer'))
    Timeslot.create(time: '12:00', duration: 60, event: Event.find_by(name: 'Test2'), user: User.find_by(full_name: 'James Doe'), role: 'Volunteer', role_number: 1)

    test_user = OmniAuth.config.mock_auth[:google_oauth2]
    User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'Officer'))

    visit '/'
    click_link 'Sign in'
    click_link 'Test2'
    expect(page).to have_content('James Doe')
    click_link 'James Doe'
    expect(page).to have_content('James Doe')
    expect(page).to have_content('User Role: Officer')
    expect(page).not_to have_link('Promote to Officer')
    expect(page).not_to have_link('Promote to President')
    expect(page).not_to have_link('Demote to User')
  end

  it "does not reveal any promotion buttons if an Officer is on the President's show page" do
    Event.create(name: 'Test3', date: '12-01-2021', volunteers: 1)
    test_user = Faker::Omniauth.google
    User.create(uid: test_user[:uid], full_name: 'Jonathan Doe', email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'President'))
    Timeslot.create(time: '12:00', duration: 60, event: Event.find_by(name: 'Test3'), user: User.find_by(full_name: 'Jonathan Doe'), role: 'Volunteer', role_number: 1)

    test_user = OmniAuth.config.mock_auth[:google_oauth2]
    User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'Officer'))

    visit '/'
    click_link 'Sign in'
    click_link 'Test3'
    expect(page).to have_content('Jonathan Doe')
    click_link 'Jonathan Doe'
    expect(page).to have_content('Jonathan Doe')
    expect(page).to have_content('User Role: President')
    expect(page).not_to have_link('Promote to Officer')
    expect(page).not_to have_link('Promote to President')
    expect(page).not_to have_link('Demote to User')
  end
end
