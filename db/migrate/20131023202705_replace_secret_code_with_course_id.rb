class ReplaceSecretCodeWithCourseId < ActiveRecord::Migration
  def up
  	add_column :lessons, :course_id, :string
  end

  def down
  	remove_column :lessons, :secret_code, :string
  end
end
