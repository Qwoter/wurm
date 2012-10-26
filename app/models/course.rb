class Course < ActiveRecord::Base
  attr_accessible :body, :end_date, :start_date, :title
end
