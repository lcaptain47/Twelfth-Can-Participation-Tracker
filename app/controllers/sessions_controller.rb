# frozen_string_literal: true

class SessionsController < ApplicationController
  # Function for login page
  def new; end

  # Creates a session for user login
  def create
    # Finds the user by email
    user = User.find_by(email: params[:sessions][:email].downcase)
    # Authenticates user via bcrypt. Redirects to homepage on successful login.
    # Redirects to login page on failed login
    if user&.authenticate(params[:sessions][:password])
      session[:user_id] = user.id

      redirect_to events_path
    else
      render 'new'
    end
  end

  # Implements logout by deleting the user ID in the session hash
  def destroy
    session[:user_id] = nil
    redirect_to events_path
  end
end
