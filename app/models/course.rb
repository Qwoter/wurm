class Course < ActiveRecord::Base
  attr_accessible :body, :end_at, :start_at, :name
  has_event_calendar
end
