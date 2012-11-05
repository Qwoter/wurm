class Course < ActiveRecord::Base
  attr_accessible :body, :end_date, :start_date, :title
  has_many :enrolments
  has_many :users, :through => :enrolments
end
