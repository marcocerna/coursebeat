class Lesson < ActiveRecord::Base
  attr_accessible :title, :date, :secret_code, :course_id

  belongs_to :course
  has_many :key_concepts, :dependent => :destroy

  validates :title, presence: true
end