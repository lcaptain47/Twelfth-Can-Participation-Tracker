# frozen_string_literal: true

class UsersController < ApplicationController
  # Shows user info
  def show
    @user = User.find(params[:id])
  end

  def wipe_all
    return unless current_user.user_role.can_delete_users

    user_role = UserRole.find_by(name: 'User')

    users = user_role.users
    users.each(&:destroy)
    flash[:notice] = 'Sytem Wiped of all normal users'
    redirect_to root_path
  end

  def destroy
    @user = User.find(params[:id])
    if current_user.user_role.can_delete_users
      flash[:notice] = "#{@user.full_name} Deleted"
      @user.destroy

      redirect_to root_path
    else
      redirect_to user_path(@user)
    end
  end
end
