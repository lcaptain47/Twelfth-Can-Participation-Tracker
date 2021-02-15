class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        @user = User.new(params.require(:user).permit(:first_name,:last_name,:email,:password))
        
        if @user.save
            @events = Event.all
            redirect_to events_path
        else
            render 'new'
        end

    end

end
