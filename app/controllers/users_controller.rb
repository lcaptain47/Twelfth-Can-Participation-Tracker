# frozen_string_literal: true

class UsersController < ApplicationController
  # Shows user info

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  # Deletes all normal users. Presidents and officers not affected
  def wipe_all
    return unless current_user.user_role.can_delete_users

    user_role = UserRole.find_by(name: 'User')

    users = user_role.users
    users.each(&:destroy)
    flash[:notice] = 'Sytem Wiped of all normal users'
    redirect_to root_path
  end

  # Deletes target user
  def destroy
    @user = User.find(params[:id])
    if current_user.user_role.can_delete_users
      flash[:notice] = "#{@user.full_name} Deleted"
      @user.destroy
    end
    redirect_to root_path
  end

  # Promotes target user
  # If Normal User: Promote to officer
  # If Officer: Promote to president and demote president to user
  def promote
    user = User.find(params[:id])

    return unless current_user.user_role.can_promote_demote

    if user.user_role.name == 'User'
      user.user_role = UserRole.find_by(name: 'Officer')
      user.save
      redirect_to user_path(user)
      return
    end

    return unless user.user_role.name == 'Officer'

    user.user_role = UserRole.find_by(name: 'President')
    user.save
    current_user.user_role = UserRole.find_by(name: 'User')
    current_user.save
    redirect_to user_path(user)
  end

  # Demotes user down one level
  def demote
    user = User.find(params[:id])

    redirect_to root_path if current_user.uid == user.uid

    return unless current_user.user_role.can_promote_demote && (user.user_role.name == 'Officer')

    user.user_role = UserRole.find_by(name: 'User')
    user.save

    redirect_to user_path(user)
  end

  def search_page
    return if current_user.user_role.can_create

    flash[:notice] = 'You are not allowed to access this page'
    redirect_to root_path
  end

  # Searches for user by name
  def search
    @users = User.where('full_name ilike ?', "%#{params[:query].strip}%")
    if @users.length.zero?
      flash[:notice] = "#{params[:query]} not found"
      redirect_to users_path
    else
      render 'index'
    end
  end
end
