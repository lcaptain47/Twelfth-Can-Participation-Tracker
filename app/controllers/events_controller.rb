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
    @timeslots = Timeslot.where(event_id: params[:id]).order(time: 'asc', role: 'asc', role_number: 'asc')

    @timeslots_matrix = []

    role_count = 1

    row = []

    #Adds timeslots for an easy to use matrix that the view will use
    total_roles = @event.volunteers + @event.front_desks + @event.runners
    @timeslots.each do |timeslot|
      
      if role_count <= total_roles
        row.push(timeslot)
        role_count += 1
      else
        @timeslots_matrix.push(row)
        row = []
        row.push(timeslot)
        role_count = 2
      end
    end

    @timeslots_matrix.push(row)

    @header = ['time']



    counter = 0
    @event.front_desks.times do
      counter += 1
      header_part = "Front Desk #{counter}"
      @header.push(header_part)
    end
    counter = 0

    @event.runners.times do
      counter += 1
      header_part = "Runner #{counter}"
      @header.push(header_part)
    end
    counter = 0
    @event.volunteers.times do
      counter += 1
      header_part = "Volunteer #{counter}"
      @header.push(header_part)
    end


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
    @event = Event.new(params.require(:event).permit(:name, :date, :description, :volunteers, :front_desks, :runners))

    if @event.save
      redirect_to @event
    else
      render 'new'
    end
  end

  # Deletes event if user has permissions to
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
