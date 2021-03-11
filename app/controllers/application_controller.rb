# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user

  # Finds the user who is in the session hash
  # Uses ||= as to not query the database when not needed
  # def current_user
  #   @current_user ||= User.find(session[:user_id]) if session[:user_id]
  # end
end
