require 'rails_helper'
require 'faker'

RSpec.describe 'Tests the user priviledges feature' do
    it 'cannot reveal create button if user is not an officer' do
        visit '/'
        click_link 'Sign in'
        expect(page).to_not have_content('New Event')
    end

    it 'reveals the create button if user is an officer' do
        test_user = OmniAuth.config.mock_auth[:google_oauth2]
        User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: "Officer"), total_approved_hours: 0.0, total_unapproved_hours: 0.0)
        visit '/'
        click_link 'Sign in'
        expect(page).to have_content('New Event')
        click_link 'New Event'
        fill_in 'event_name', with: 'Test'
        click_on 'Create Event'
        expect(page).to have_content('Test')
    end

    it 'redirects user to index page if they try to create an event' do
        visit '/'
        click_link 'Sign in'
        EventsController.new
        expect(page).to have_content('Sign Out')
    end

    it 'cannot reveal delete button if user is not an officer' do
        Event.create(name: "Test" , date: '12-01-2021')
        Timeslot.create(time: "12:00", duration: 60, event: Event.first)
        visit '/'
        click_link 'Sign in'
        click_link 'Test'
        expect(page).to_not have_content('Delete')
        
        
    end

    it 'reveals delete button if user is an officer and it allows delete' do
        test_user = OmniAuth.config.mock_auth[:google_oauth2]
        User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: "Officer"), total_approved_hours: 0.0, total_unapproved_hours: 0.0)
        Event.create(name: "Test" , date: '12-01-2021')
        Timeslot.create(time: "12:00", duration: 60, event: Event.first)
        
        visit '/'
        click_link 'Sign in'
        click_link 'Test'
        expect(page).to have_content('Delete')
        click_link 'Delete'
        expect(page).to have_content('Sign Out')
        
    end

    it 'reveals add timeslot button if user is an officer and it allows creation' do
        test_user = OmniAuth.config.mock_auth[:google_oauth2]
        User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: "Officer"), total_approved_hours: 0.0, total_unapproved_hours: 0.0)
        Event.create(name: "Test" , date: '12-01-2021')

        visit '/'
        click_link 'Sign in'
        click_link 'Test'
        expect(page).to have_content('Add Timeslots')
        click_link 'Add Timeslots'
        fill_in 'timeslot_count', with: 60
        select '04', from: 'timeslot_start_time_4i'
        select '00', from: 'timeslot_start_time_5i'
        select '04', from: 'timeslot_end_time_4i'
        select '00', from: 'timeslot_end_time_5i'
        click_on 'Create Timeslot'
        expect(page).to have_content('4:00 am')

    end

    it 'does not reveal the add timeslot button if user is not an officer and redirects them to event page' do
        Event.create(name: "Test" , date: '12-01-2021')

        visit '/'
        click_link 'Sign in'
        click_link 'Test'
        expect(page).to_not have_content('Add Timeslots')
        TimeslotsController.new

        expect(page).to_not have_content('Start time')
    end

    # it 'Lets user claim timeslot' do
    #     Event.create(name: "Test", date: "12-01-2021")
    #     Timeslot.create(time: "12:00", duration: 60, event: Event.first)
    #     visit '/'
    #     click_link 'Sign in'
    #     click_link "Test"
    #     click_link "Claim"
    #     expect(page).to have_content("Lucas Campbell")
    # end
end