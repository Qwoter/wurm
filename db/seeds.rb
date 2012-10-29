# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = [{:email => 'asd@asd.asd', :password => 'asdasd', :password_confirmation => 'asdasd'}]

users.each do |user|
  User.create(user)
end

courses = [{title: "Example Course", body: "You can do any examples in this course!", start_date: "2012-10-29", end_date: "2013-10-29"},
           {title: "Running!", body: "Run Run Run Run Run Run Run Run Run Run Run Run Run...", start_date: "2012-10-29", end_date: "2012-12-31"}]
           
courses.each do |course|
  Course.create(course)
end
