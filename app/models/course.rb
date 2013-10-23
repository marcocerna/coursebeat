class Course < ActiveRecord::Base
  attr_accessible :secret_code

  has_many :course_instructors
  has_many :instructors, through: :course_instructors
end
