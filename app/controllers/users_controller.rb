# frozen_string_literal: true

class UsersController < ApplicationController
  # Shows user info
  def show
    @user = User.find(params[:id])
  end

  def wipe_all
    if current_user.user_role.can_delete_users
      @user.each do
      if user != current_user
        @user.delete
      end

    #if user is not an officer or preseident delete them
    end
  end

  end
  
end
