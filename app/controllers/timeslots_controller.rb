class TimeslotsController < ApplicationController

    def new

    end

    def create
        
        count = params[:timeslot][:count].to_i

        start_time_hour = params[:timeslot]["start_time(4i)"].to_i
        end_time_hour = params[:timeslot]["end_time(4i)"].to_i

        start_time_minute = params[:timeslot]["start_time(5i)"].to_i
        end_time_minute = params[:timeslot]["end_time(5i)"].to_i

        # start_time_hour_in_minutes = (start_time_hour * 60) + start_time_minute
        # end_time_hour_in_minutes = (end_time_hour * 60) + end_time_minute


        minutes = start_time_minute
        hours = start_time_hour

        while minutes <= end_time_minute || hours < end_time_hour

            byebug
            
            timeslot = Timeslot.new

            string_time = "#{hours}:#{minutes}"

            timeslot.time = string_time
            timeslot.duration = count

            
            timeslot.save


            if minutes == 60
                minutes = 0
                hours = hours + 1
            else
                minutes += count
            end
        end

        
        
        
    end


end
