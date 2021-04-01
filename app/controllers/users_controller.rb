# frozen_string_literal: true

class UsersController < ApplicationController
  # Shows user info

  def index 
    @user = User.all 
  end

  def show
    @user = User.find(params[:id])
  end
end
