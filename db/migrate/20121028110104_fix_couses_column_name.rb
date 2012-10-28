class FixCousesColumnName < ActiveRecord::Migration
  def self.up
    rename_column :courses, :start_date, :start_at
    rename_column :courses, :end_date, :end_at
  end

  def self.down
    rename_column :courses, :start_at,:start_date
    rename_column :courses, :end_at, :end_date 
  end
end
