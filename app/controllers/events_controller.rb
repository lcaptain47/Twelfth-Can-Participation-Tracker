class EventsController < ApplicationController
    def index
        #comment
        @events = Event.all

    end
end
