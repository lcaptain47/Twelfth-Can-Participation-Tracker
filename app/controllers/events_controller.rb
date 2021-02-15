class EventsController < ApplicationController
    def index
        #comments
        @events = Event.all

    end

    def show
        @event = Event.find(params[:id])
    end

    def new

    end

    def create
        byebug
    end
end
