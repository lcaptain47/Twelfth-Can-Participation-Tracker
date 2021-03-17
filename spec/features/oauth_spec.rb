require 'rails_helper'
require 'faker'

RSpec.describe 'Testing Google Oauth' do

    # it 'Prints out first role' do
    #     puts UserRole.first.name
    #     puts UserRole.first.id
    #     puts UserRole.last.id
    # end

    it 'Redirects user to homepage, no matter where they go to if not logged in' do
        visit '/'
        expect(page).to have_content('Sign in')
    end

    it 'Signs the user into a google account, takes them to the homepage, and displays their name.' do
        visit '/'
        click_link 'Sign in'
        expect(page).to have_content('Lucas Campbell')
        expect(page).to have_content('Sign Out')
    end

    it 'Denies log in when invalid credentials are inputted' do
        OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials

        visit '/'
        click_link 'Sign in'
        expect(page).to have_content('Sign in')

        OmniAuth.config.mock_auth[:google_oauth2] = Faker::Omniauth.google
        OmniAuth.config.mock_auth[:google_oauth2][:info][:name] = "Lucas Campbell"

        
        
    end
    
end