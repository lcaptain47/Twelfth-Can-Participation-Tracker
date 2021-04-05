# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe 'Tests the approve and unapprove features' do
  it 'Lets an officer approve and unapprove their own timeslot' do
    Event.create(name: 'Test', date: '12-01-2021', volunteers: 1)
    Timeslot.create(time: '12:00', duration: 60, event: Event.first, role: 'Volunteer', role_number: 1)
    # test_user = Faker::Omniauth.google
    test_user = OmniAuth.config.mock_auth[:google_oauth2]
    User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'Officer'))
    
    visit '/'
    click_link 'Sign in'
    click_link 'Test'
    click_link 'Claim'
    expect(page).to have_content('Approve')
    click_link 'Approve'
    click_link test_user[:info][:name]
    expect(page).to have_content('Total Approved Hours: 1.0')
    expect(page).to have_content('Total Volunteer Hours: 1.0')
    click_link 'Homepage'
    click_link 'Test'
    click_link 'Unapprove'
    click_link test_user[:info][:name]
    expect(page).to have_content('Total Unapproved Hours: 1.0')
    expect(page).to have_content('Total Volunteer Hours: 0.0')
  end

  it 'Lets an officer approve another users timeslot' do
    Event.create(name: 'Test', date: '12-01-2021', volunteers: 1)
    Timeslot.create(time: '12:00', duration: 60, event: Event.first, role: 'Volunteer', role_number: 1)
    # test_user = Faker::Omniauth.google
    test_user = OmniAuth.config.mock_auth[:google_oauth2]
    User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'Officer'))
    visit '/'
    click_link 'Sign in'
    user = User.first
    user.user_role = UserRole.find_by(name: 'User')
    user.save
    click_link 'Test'
    click_link 'Claim'
    click_link 'Homepage'
    click_link 'Sign Out'
    click_link 'Sign in'
    user = User.first
    user.user_role = UserRole.find_by(name: 'President')
    user.save
    click_link 'Test'
    click_link 'Approve'
    click_link 'Lucas Campbell'
    expect(page).to have_content('Total Approved Hours: 1.0')
    expect(page).to have_content('Total Volunteer Hours: 1.0')
  end

  it 'Makes sure that normal users can not see the approve button' do
    Event.create(name: 'Test', date: '12-01-2021', volunteers: 1)
    Timeslot.create(time: '12:00', duration: 60, event: Event.first, role: 'Volunteer', role_number: 1)
    # test_user = Faker::Omniauth.google
    test_user = OmniAuth.config.mock_auth[:google_oauth2]
    User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'Officer'))
    visit '/'
    click_link 'Sign in'
    user = User.first
    user.user_role = UserRole.find_by(name: 'User')
    user.save
    click_link 'Test'
    click_link 'Claim'
    expect(page).not_to have_content('Approve')
    expect(page).not_to have_content('Unapprove')
  end

  it 'Tests the unclaim feature for the right values' do
    Event.create(name: 'Test', date: '12-01-2021', volunteers: 1)
    Timeslot.create(time: '12:00', duration: 60, event: Event.first, role: 'Volunteer', role_number: 1)
    # test_user = Faker::Omniauth.google
    test_user = OmniAuth.config.mock_auth[:google_oauth2]
    User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'Officer'))
    visit '/'
    click_link 'Sign in'
    click_link 'Test'
    click_link 'Claim'
    click_link 'Approve'
    click_link 'Unclaim'
    click_link 'Homepage'
    click_link 'Lucas Campbell'
    expect(page).to have_content('0.0', count: 5)
  end


end
