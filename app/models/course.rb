class Course < ActiveRecord::Base
  attr_accessible :course_name, :secret_code

  has_many :lessons
  has_many :course_instructors
  has_many :instructors, through: :course_instructors

  validates :course_name, presence: true
  # validates :instructor, through: :course_instructors, presence: true
end
