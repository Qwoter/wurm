class Course < ActiveRecord::Base
  attr_accessible :body, :end_date, :start_date, :title
  has_many :users
  has_many :users, :through => :enrolments
end
