class AddRatingsToSubConcept < ActiveRecord::Migration
  def change
  	add_column :sub_concepts, :ratingCount, :integer
  	add_column :sub_concepts, :ratingAverage, :float
  end
end
