class ReplaceCourseId < ActiveRecord::Migration
  def change
  	remove_column :lessons, :course_id, :string
  	add_column :lessons, :course_id, :integer
  end
end
