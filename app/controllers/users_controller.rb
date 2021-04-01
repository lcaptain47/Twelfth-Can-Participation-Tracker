# frozen_string_literal: true

class UsersController < ApplicationController
  # Shows user info

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def search_page; end

  def search
    @users = User.where(full_name: params[:query].strip)
    if @users.length.zero?
      flash[:notice] = "#{params[:query]} not found"
      redirect_to users_path
    else
      render 'index'
    end
  end
end
