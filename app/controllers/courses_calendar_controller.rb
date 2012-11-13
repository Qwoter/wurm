class CoursesCalendarController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    # TO DO Show calendar
  end
  def my_cal
  	# @my_date = params[:date] ? Date.parse(params[:date]) : Date.today
		@my_date = Date.today
		@lessons = Course.all
		@lessons.each do |lesson|
			if lesson.user_ids.empty?
			else
				@my_course += lesson.user_ids.select{|uid| uid == current_user.id }
				@my_course.compact!
			end
		end
		@lessons = @my_course

		@lessons_by_start_date = @lessons.group_by(&:start_at)
		@lessons_by_end_date = @lessons.group_by(&:end_at)
		# @count = Course.select{|c| c.start_at <= date || c.end_at >= date}.count
		Calendar.new(self,date,block).table

  end
end