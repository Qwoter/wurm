class CreateEnrolment < ActiveRecord::Migration
  def change
    create_table(:enrolments) do |t|
      t.references :user
      t.references :course
    end
  end
end
