# frozen_string_literal: true

class UsersController < ApplicationController
  # Prepares new user sign up form
  def new
    @user = User.new
  end

  # Creates the user with input from new user form
  def create
    @user = User.new(params.require(:user).permit(:first_name, :last_name, :email, :password))

    if @user.save
      @events = Event.all
      redirect_to events_path
    else
      render 'new'
    end
  end
end
