class AddInstructorSecretCode < ActiveRecord::Migration
  def up
  	add_column :instructors, :instructor_secret_code, :string
  end

  def down
  end
end
