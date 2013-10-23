class CreateCourseInstructors < ActiveRecord::Migration
  def change
    create_table :course_instructors do |t|

      t.timestamps
    end
  end
end
