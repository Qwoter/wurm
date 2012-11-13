module CalendarHelper
	def calendar(date = Date.today, &block)
		# @my_date = params[:date] ? Date.parse(params[:date]) : Date.today
		@my_date = Date.today
		@lessons = Course.all
		@lessons_by_start_date = @lessons.group_by(&:start_at)
		@lessons_by_end_date = @lessons.group_by(&:end_at)
		# @count = Course.select{|c| c.start_at <= date || c.end_at >= date}.count
		Calendar.new(self,date,block).table

	end
	def my_cal(date = Date.today, &block)
		# @my_date = params[:date] ? Date.parse(params[:date]) : Date.today
		@my_date = Date.today
		@lessons = Course.all
		@lessons.each do |lesson|
				@my_course += lesson.user_ids.select{|uid| uid == current_user.id }
				@my_course.compact!
		end
		@lessons = @my_course

		@lessons_by_start_date = @lessons.group_by(&:start_at)
		@lessons_by_end_date = @lessons.group_by(&:end_at)
		# @count = Course.select{|c| c.start_at <= date || c.end_at >= date}.count
		Calendar.new(self,date,block).table

	end
	
	class Calendar < Struct.new(:view,:date,:callback)
		HEADER = %W[Sunday Monday Tuesday Wednesday Thursday Friday Saturday]
		START_DAY = :sunday

		delegate :content_tag, to: :view

		def table
			content_tag :table, class: "calendar" do
				header + week_rows
			end
		end

		def header
			content_tag :tr do 
				HEADER.map{|day| content_tag :th , day }.join.html_safe
			end
		end

		def week_rows
			weeks.map do |week|
				content_tag :tr do 
					week.map{|day| day_cell(day)}.join.html_safe
				end
			end.join.html_safe
		end

		def day_cell(day)
			content_tag :td, view.capture(day, &callback), class:day_classes(day)
		end

		def day_classes(day)
			classes = []
			classes << "today" if day = Date.today
			classes << "notmonth" if day.month != date.month
			classes.empty? ? nil : classes.join(" ")
		end

		def weeks
			first = date.beginning_of_month.beginning_of_week(START_DAY)
			last = date.end_of_month.end_of_week(START_DAY)
			(first..last).to_a.in_groups_of(7)
		end
	end
end