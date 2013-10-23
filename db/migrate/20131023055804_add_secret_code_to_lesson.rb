class AddSecretCodeToLesson < ActiveRecord::Migration
  def change
  	add_column :lessons, :secret_code, :string
  end
end
