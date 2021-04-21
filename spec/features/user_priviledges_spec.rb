# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe 'Tests the user priviledges feature' do
  it 'cannot reveal create button if user is not an officer' do
    visit '/'
    click_link 'Sign in'
    expect(page).not_to have_content('New Event')
  end

  it 'reveals the create button if user is an officer' do
    test_user = OmniAuth.config.mock_auth[:google_oauth2]
    User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'Officer'))
    visit '/'
    click_link 'Sign in'
    expect(page).to have_content('New Event')
    click_link 'New Event'
    fill_in 'event_name', with: 'Test'
    fill_in 'event_volunteers', with: 1
    click_on 'Create Event'
    sleep 5
    expect(page).to have_content('Test')
  end

  it 'redirects user to index page if they try to create an event' do
    visit '/'
    click_link 'Sign in'
    EventsController.new
    expect(page).to have_content('Sign Out')
  end

  it 'cannot reveal delete button if user is not an officer' do
    Event.create(name: 'Test', date: '12-01-2021', volunteers: 1)
    Timeslot.create(time: '12:00', duration: 60, event: Event.first, role: 'Volunteer', role_number: 1)
    visit '/'
    click_link 'Sign in'
    click_link 'Test'
    expect(page).not_to have_content('Delete')
  end

  it 'reveals delete button if user is an officer and it allows delete' do
    test_user = OmniAuth.config.mock_auth[:google_oauth2]
    User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'Officer'))
    Event.create(name: 'Test', date: '12-01-2021', volunteers: 1)
    Timeslot.create(time: '12:00', duration: 60, event: Event.first, role: 'Volunteer', role_number: 1)

    visit '/'
    click_link 'Sign in'
    click_link 'Test'
    expect(page).to have_content('Delete')
    page.accept_confirm do
      click_link 'Delete'
    end

    sleep(1)

    expect(page).to have_content('Sign Out')
  end

  it 'reveals add timeslot button if user is an officer and it allows creation' do
    test_user = OmniAuth.config.mock_auth[:google_oauth2]
    User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'Officer'))
    Event.create(name: 'Test', date: '12-01-2021', volunteers: 1)

    visit '/'
    click_link 'Sign in'
    click_link 'Test'
    expect(page).to have_content('Add Timeslots')
    click_link 'Add Timeslots'
    fill_in 'timeslot_count', with: 60
    select '04', from: 'timeslot_start_time_4i'
    select '00', from: 'timeslot_start_time_5i'
    select '05', from: 'timeslot_end_time_4i'
    select '00', from: 'timeslot_end_time_5i'
    click_on 'Create Timeslot'
    expect(page).to have_content('4:00 am')
  end

  it 'does not reveal the add timeslot button if user is not an officer and redirects them to event page' do
    Event.create(name: 'Test', date: '12-01-2021', volunteers: 1)

    visit '/'
    click_link 'Sign in'
    sleep(5)
    click_link 'Test'
    expect(page).not_to have_content('Add Timeslots')
    TimeslotsController.new

    expect(page).not_to have_content('Start time')
  end
end
