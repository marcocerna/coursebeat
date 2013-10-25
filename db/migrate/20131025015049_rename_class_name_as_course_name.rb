class RenameClassNameAsCourseName < ActiveRecord::Migration
  def change
  	rename_column :courses, :class_name, :course_name
  end
end
