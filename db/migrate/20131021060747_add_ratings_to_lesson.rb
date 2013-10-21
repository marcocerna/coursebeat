class AddRatingsToLesson < ActiveRecord::Migration
  def change
  	add_column :lessons, :ratingCount, :integer
  end
end
