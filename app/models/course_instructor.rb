class CourseInstructor < ActiveRecord::Base
  attr_accessible :course_id, :instructor_id

  belongs_to :course 
  belongs_to :instructor 
end
