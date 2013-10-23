class CreateCourseInstructors < ActiveRecord::Migration
  def change
    create_table :course_instructors do |t|
    	t.references :course 
    	t.references :instructor 
      t.timestamps
    end
  end
end
