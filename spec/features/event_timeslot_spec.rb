# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Tests the new event and timeslot system' do
  it 'Creates the event with the inputted amount of roles' do
    test_user = OmniAuth.config.mock_auth[:google_oauth2]
    User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'Officer'))
    visit '/'
    click_link 'Sign in'
    click_link 'New Event'
    fill_in 'event_name', with: 'Test'
    fill_in 'event_volunteers', with: 3
    fill_in 'event_front_desks', with: 3
    fill_in 'event_runners', with: 3
    fill_in 'event_description', with: 'Bleh'
    click_on 'Create Event'
    expect(page).to have_content('Volunteers: 3')
    expect(page).to have_content('Runners: 3')
    expect(page).to have_content('Front Desks: 3')
  end

  it 'Does the above and creates timeslots and has 27 timeslot claim buttons' do
    test_user = OmniAuth.config.mock_auth[:google_oauth2]
    User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'Officer'))
    visit '/'
    click_link 'Sign in'
    click_link 'New Event'
    fill_in 'event_name', with: 'Test'
    fill_in 'event_volunteers', with: 3
    fill_in 'event_front_desks', with: 3
    fill_in 'event_runners', with: 3
    fill_in 'event_description', with: 'Bleh'
    click_on 'Create Event'
    click_link 'Add Timeslots'
    fill_in 'timeslot_count', with: 60
    select '04', from: 'timeslot_start_time_4i'
    select '00', from: 'timeslot_start_time_5i'
    select '06', from: 'timeslot_end_time_4i'
    select '00', from: 'timeslot_end_time_5i'
    click_on 'Create Timeslot'
    expect(page).to have_content('Claim', count: 18)
  end

  it 'Does not let user use a smaller end time and bigger start time' do
    test_user = OmniAuth.config.mock_auth[:google_oauth2]
    User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'Officer'))
    Event.create(name: 'Test', date: '12-01-2021', volunteers: 3, front_desks: 3, runners: 3)
    visit '/'
    click_link 'Sign in'
    click_link 'Test'
    click_link 'Add Timeslots'
    fill_in 'timeslot_count', with: 60
    select '06', from: 'timeslot_start_time_4i'
    select '00', from: 'timeslot_start_time_5i'
    select '04', from: 'timeslot_end_time_4i'
    select '00', from: 'timeslot_end_time_5i'
    click_on 'Create Timeslot'
    expect(page).to have_content('You cannot use an end time smaller than or equal to your start time')
  end
end
