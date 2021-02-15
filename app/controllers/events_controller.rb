class EventsController < ApplicationController
    def index
        #comments
        @events = Event.all

    end

    def show
        @event = Event.find(params[:id])
        @timeslots = @event.timeslots
        @timeslots = Timeslot.where(:event_id => params[:id]).order("time")
        # byebug
        
    end

    def new

    end

    def create
        byebug
    end
end
