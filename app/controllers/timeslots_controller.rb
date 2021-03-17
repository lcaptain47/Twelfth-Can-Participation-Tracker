# frozen_string_literal: true

require 'time'
class TimeslotsController < ApplicationController
  # Prepares new timeslot form
  def new
    @timeslot = Timeslot.new(event_id: params[:event_id])
    @event = Event.find(params[:event_id])
  end

  # Post Route function for timeslot
  def create
    # Used as increment
    count = params[:timeslot][:count].to_i

    # Formats time parameters for use in Time object
    start_time_hour = params[:timeslot]['start_time(4i)'].to_i
    end_time_hour = params[:timeslot]['end_time(4i)'].to_i
    start_time_minute = params[:timeslot]['start_time(5i)'].to_i
    end_time_minute = params[:timeslot]['end_time(5i)'].to_i

    # Formats start time
    minutes = start_time_minute
    hours = start_time_hour
    string_time = "#{hours}:#{minutes}"

    # Creates Time objects for start and end time
    end_time = Time.find_zone('UTC').parse("#{end_time_hour}:#{end_time_minute}")
    time = Time.find_zone('UTC').parse(string_time)

    # Redirects to new form if count is not provided and if start time is larger than end time
    # Creates Timeslot objects otherwise
    if time > end_time || count < 10
      redirect_to new_timeslot_path(event_id: params[:timeslot][:event_id])
    else
      # Creates timeslots by starting at start time and skip counting
      # (using 'count' variable) to end time
      while time <= end_time

        timeslot = Timeslot.new
        timeslot.time = time
        timeslot.duration = count
        timeslot.event_id = params[:timeslot][:event_id]

        timeslot.save

        time += (count * 60)
      end

      # Redirects to the event page for the timslots' event
      @eventid = params[:timeslot][:event_id]
      @event_exit = Event.find(@eventid)
      redirect_to @event_exit
    end
  end

  def claim
    timeslot = Timeslot.find(params[:id])
    if !timeslot.user.nil?
      flash[:notice] = 'Timeslot is already claimed claimed'
      @events = Event.all
      redirect_to events_path
    else
      flash[:notice] = 'Timeslot claimed'
      timeslot.user = current_user
      timeslot.save

      redirect_to event_path(timeslot.event)
    end
  end
end
