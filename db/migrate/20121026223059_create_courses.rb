class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.text :body
      t.date :start_at
      t.date :end_at

      t.timestamps
    end
  end
end
