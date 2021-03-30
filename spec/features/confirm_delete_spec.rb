require 'rails_helper'
require 'faker'


RSpec.describe 'Tests the confirm delete feature' do

    it 'displays a confirmation message if user is an officer' do
        test_user = OmniAuth.config.mock_auth[:google_oauth2]
        User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'Officer'))
        Event.create(name: 'Test', date: '12-01-2021')
        Timeslot.create(time: '12:00', duration: 60, event: Event.first)

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

    it 'displays a confirmation message if user is the president' do
        test_user = OmniAuth.config.mock_auth[:google_oauth2]
        User.create(uid: test_user[:uid], full_name: test_user[:info][:name], email: test_user[:info][:email], avatar_url: test_user[:info][:image], user_role: UserRole.find_by(name: 'President'))
        Event.create(name: 'Test2', date: '12-01-2021')
        Timeslot.create(time: '12:00', duration: 60, event: Event.first)

        visit '/'
        click_link 'Sign in'
        click_link 'Test2'
        expect(page).to have_content('Delete')
        
        page.accept_confirm do
            click_link 'Delete'
        end

        sleep(1)

        expect(page).to have_content('Sign Out')

        
    end

    it 'hides the delete button if user is not an officer or president' do
        Event.create(name: 'Test', date: '12-01-2021')
        Timeslot.create(time: '12:00', duration: 60, event: Event.first)
        visit '/'
        click_link 'Sign in'
        click_link 'Test'
        expect(page).not_to have_content('Delete')
        
        
    end

end
