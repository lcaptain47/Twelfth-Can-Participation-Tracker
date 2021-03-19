require 'rails_helper'
require 'faker'

RSpec.describe 'Tests unclaim and claim features' do
    it 'Lets user claim timeslot' do
        Event.create(name: "Test", date: "12-01-2021")
        Timeslot.create(time: "12:00", duration: 60, event: Event.first)
        visit '/'
        click_link 'Sign in'
        click_link "Test"
        click_link "Claim"
        expect(page).to have_content("Lucas Campbell")
        expect(page).to have_content("Unclaim")
 
    end

    it 'Does not show unclaim if user does not own that timeslot' do
        Event.create(name: "Test", date: "12-01-2021")
        test_user = Faker::Omniauth.google
        User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: "User"), total_approved_hours: 0.0, total_unapproved_hours: 0.0)
        Timeslot.create(time: "12:00", duration: 60, event: Event.first, user: User.first)

        visit '/'
        click_link 'Sign in'
        click_link "Test"
        expect(page).to_not have_content('Unclaim')
    end

    it 'Shows unclaim button if user is an officer' do
        Event.create(name: "Test", date: "12-01-2021")
        test_user = Faker::Omniauth.google
        User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: "User"), total_approved_hours: 0.0, total_unapproved_hours: 0.0)
        Timeslot.create(time: "12:00", duration: 60, event: Event.first, user: User.first)

        test_user = OmniAuth.config.mock_auth[:google_oauth2]
        User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: "Officer"), total_approved_hours: 0.0, total_unapproved_hours: 0.0)

        visit '/'
        click_link 'Sign in'
        click_link "Test"
        sleep 5
        expect(page).to have_content('Unclaim')
    end
end