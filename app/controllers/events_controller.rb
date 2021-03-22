# frozen_string_literal: true

class EventsController < ApplicationController
  # Prepares events index page
  def index
    @events = Event.all
  end

  # Prepares show page of an event
  def show
    @event = Event.find(params[:id])
    @timeslots = @event.timeslots
    @timeslots = Timeslot.where(event_id: params[:id]).order('time')
  end

  # Prepares form for a new event
  def new
    if current_user.user_role.can_create
      @event = Event.new
    else
      redirect_to events_path
    end
  end

  # Creates event from input of new event form
  def create
    @event = Event.new(params.require(:event).permit(:name, :date))

    if @event.save
      redirect_to @event
    else
      render 'new'
    end
  end

  #Deletes event if user has permissions to
  def destroy
    if current_user.user_role.can_delete
      @event = Event.find(params[:id])
      @event.destroy

      @events = Event.all
      redirect_to root_path
    else
      redirect_to event_path(@event)
    end
  end
end
