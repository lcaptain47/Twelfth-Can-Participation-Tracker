# README
This includes a guide on how to run the application locally and how to deploy it to Heroku.

* Ruby version: 2.7.2
* Rails Version: 6.1.1

* System dependencies
  * Ubuntu (Either with WSL, VM or with regular Ubuntu. At least 18.x.)
  * Gems
    * Pg
    * Puma
    * Webpacker
    * Turbolinks
    * Jbuilder
    * Bcrypt
    * Devise
    * Omniauth
    * Omniauth-google-oauth2
    * Bootsnap
    * simplecov
    * byebug
    * rubocop
      * performance
      * rails
      * rspec
    * Web console
    * Listen
    * Spring
    * Brakeman
    * Capybara
    * Rspec-rails
    * Selenium-webdriver
    * Faker
    * Webdrivers
    * Tzinfo-data
* How to run
  * Basic start up 
    1. Clone repository
    2. In root folder, run: ```rails db:migrate``` and ```rails db:seed```
    3. Run ```rails s``` to start the server
  * How to create a user of any role
    1. Log into the application via a google account
    2. Run ```rails c```
    3. In the rails console run ```user = User.first``` or ```user = User.find_by(full_name: "full-name-here")```
    4. Run ```user.user_role = UserRole.find_by(name: "role-name-here")```. Roles include "User", "Officer", or "President"
  * If you can't log in because google says that the address wasn't added to the oauth list, contact lcaptain47

* How to run the test suite
  * The application uses Rspec for testing
  * Run ```rspec .``` in the root directory to run the entire test suite
  * Run ```rspec spec/path/to/test.rb``` to run a specific spec file
  * Run ```bundle exec rubocop --auto-correct``` to run rubocop and have it autocorrect most errors
  * Run ```bundle exec brakeman -o brakeman.txt``` to run brakeman and have it output it's log to a text file in the root directory

* Deployment instructions
  * Basic deployment instructions can be found here: https://devcenter.heroku.com/articles/getting-started-with-rails6
  * The application includes a proc file which runs ```rails db:migrate``` and ```rails db:seed``` automatically
  * If they do not run, do the following
    1. Install the Heroku CLI: https://devcenter.heroku.com/articles/heroku-cli#download-and-install
    2. Run ```heroku run rails c -a app-name-here```
    3. Run ```rails db:migrate``` and then ```rails db:seed```
    4. If you need a list of apps under your heroku account run: ```heroku apps```
  * Troubleshooting
    * If you cannot connect to the database on Heroku, make sure that the application has a postgres server, as sometimes Heroku doesn't add one.
    * If you are getting issues with installing mimemagic (a gem), try running ```bundle update mimemagic``` before deployment 
