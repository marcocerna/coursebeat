class CreateSubConcepts < ActiveRecord::Migration
  def change
    create_table :sub_concepts do |t|
    	t.string :info
    	t.references :key_concept
      t.timestamps
    end
  end
end
