# frozen_string_literal: true

require 'time'
class TimeslotsController < ApplicationController
  def new
    @timeslot = Timeslot.new(event_id: params[:event_id])
    @event = Event.find(params[:event_id])
  end

  def create
    count = params[:timeslot][:count].to_i

    start_time_hour = params[:timeslot]['start_time(4i)'].to_i
    end_time_hour = params[:timeslot]['end_time(4i)'].to_i

    start_time_minute = params[:timeslot]['start_time(5i)'].to_i
    end_time_minute = params[:timeslot]['end_time(5i)'].to_i

    minutes = start_time_minute
    hours = start_time_hour

    string_time = "#{hours}:#{minutes}"

    end_time = Time.find_zone('UTC').parse("#{end_time_hour}:#{end_time_minute}")

    time = Time.find_zone('UTC').parse(string_time)

    if time > end_time || count < 10
      redirect_to new_timeslot_path(event_id: params[:timeslot][:event_id])
    else
      while time <= end_time

        timeslot = Timeslot.new
  
        timeslot.time = time
        timeslot.duration = count
        timeslot.event_id = params[:timeslot][:event_id]
  
        timeslot.save
  
        time += (count * 60)
      end
  
      @eventid = params[:timeslot][:event_id]
      @eventExit = Event.find(@eventid)
      redirect_to @eventExit
    end

    
  end
end
