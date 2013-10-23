class CourseInstructor < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :course 
  belongs_to :instructor 
end
