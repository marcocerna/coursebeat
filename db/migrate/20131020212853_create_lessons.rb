class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
		t.string :title
		t.date :date
      t.timestamps
    end
  end
end
