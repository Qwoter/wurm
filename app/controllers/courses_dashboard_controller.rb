class CoursesDashboardController < ApplicationController
  def index
    # TO DO Show all courses
    @courses = Course.all
  end
end