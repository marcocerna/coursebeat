class Course < ActiveRecord::Base
  attr_accessible :class_name, :secret_code

  has_many :lessons
  has_many :course_instructors
  has_many :instructors, through: :course_instructors
end
