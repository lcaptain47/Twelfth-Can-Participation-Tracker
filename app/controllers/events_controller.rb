class EventsController < ApplicationController
    def index
        #index
        @events = Event.all
        byebug

    end

    def show
        @event = Event.find(params[:id])
        @timeslots = @event.timeslots
        @timeslots = Timeslot.where(:event_id => params[:id]).order("time")
        
    end

    def new
        @event = Event.new
    end

    def create
        @event = Event.new(params.require(:event).permit(:name,:date))

        if @event.save
            redirect_to @event
        else
            render 'new'
        end
        
    end
end
