class Instructor < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation, :instructor_secret_code
  has_secure_password

  before_save :create_remember_token

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true

  def create_remember_token
  	self.remember_token = SecureRandom.urlsafe_base64
  end

  has_many :course_instructors
  has_many :courses, through: :course_instructors

end
