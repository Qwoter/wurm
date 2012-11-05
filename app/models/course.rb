class Course < ActiveRecord::Base
  attr_accessible :body, :end_at, :start_at, :name

  has_event_calendar
  has_many :users
  has_many :users, :through => :enrolments
end
