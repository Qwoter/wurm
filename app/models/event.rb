class Event < ActiveRecord::Base
  attr_accessible :id, :name, :start_at, :end_at
  has_event_calendar
end
