# frozen_string_literal: true

class UsersController < ApplicationController
  # Shows user info
  def show
    @user = User.find(params[:id])
  end

  def wipe_all
    
  end
  
end
