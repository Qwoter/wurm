class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title
      t.string :body
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
