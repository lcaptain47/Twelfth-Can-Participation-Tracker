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
        # test_user = OmniAuth.config.mock_auth[:google_oauth2]
        # User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: "Officer"), total_approved_hours: 0.0, total_unapproved_hours: 0.0)
        visit '/'
        click_link 'Sign in'
        EventsController.new
        expect(page).to have_content('Sign Out')
    end

    it 'Lets user claim timeslot' do
        Event.create(name: "Test", date: "12-01-2021")
        Timeslot.create(time: "12:00", duration: 60, event: Event.first)
        visit '/'
        click_link 'Sign in'
        click_link "Test"
        click_link "Claim"
        expect(page).to have_content("Lucas Campbell")
    end
end