# module CalendarHelper
#   def month_link(month_date)
#     link_to(I18n.localize(month_date, :format => "%B"), {:month => month_date.month, :year => month_date.year})
#   end
  
#   # custom options for this calendar
#   def event_calendar_opts
#     { 
#       :year => @year,
#       :month => @month,
#       # :event_strips => [] ,
#       # :use_all_day => true,
      
      
#       :event_strips => @event_strips,
#       :month_name_text => I18n.localize(@shown_month, :format => "%B %Y"),
#       :previous_month_text => "<< " + month_link(@shown_month.prev_month),
#       :next_month_text => month_link(@shown_month.next_month) + " >>"    }
#   end

#   def event_calendar
#     # args is an argument hash containing :event, :day, and :options
#     # calendar event_calendar_opts do |args|
#     #   event = args[:event]
#     #   %(<a href="/courses/#{event.id}" title="#{h(event.name)}">#{h(event.name)}</a>)
#     # end
#     calendar event_calendar_opts do |args|
#       event, day = args[:event], args[:day]
      
#       html = %(<a href="/courses/#{event.id}" title="#{h(event.name)}">)
#       # html << display_event_time(event, day)
#       # html << Course.all.select{|c| c.start_at<= day && c.end_at >= day}.count.to_s
#       html << %(#{h(event.name)})
#       # html
#       # html = ""
#       # html << Course.all.select{|c| c.start_at<= day && c.end_at >= day}.count.to_s
#     end
#   end

#   # def event_strips_for_month(shown_date, first_day_of_week=0, find_options = {})
#   #   if first_day_of_week.is_a?(Hash)
#   #     find_options.merge!(first_day_of_week)
#   #     first_day_of_week =  0
#   #   end
#   #   strip_start, strip_end = get_start_and_end_dates(shown_date, first_day_of_week)
#   #   events = events_for_date_range(strip_start, strip_end, find_options)
#   #   event_strips = create_event_strips(strip_start, strip_end, events)
#   #   # event_strips
#   # end
#   # def event_table 
#   #   Course.each do |c|
#   #     event = Event.new(
#   #     :id => c.id,
#   #     :name => c.name,
#   #     :start_at => c.start_at,
#   #     :end_at => c.start_at
#   #     )
#   #     event.save
#   #   end
#   # end
#  end
# #################################################################3
#  
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