class FixCourseTitleToName < ActiveRecord::Migration
  def up
  	rename_column :courses, :title, :name
  end

  def down
  	rename_column :courses, :name, :title 
  end
end
