class Lesson < ActiveRecord::Base
  attr_accessible :title, :date

  has_many :key_concepts

  validates :title, presence: true, uniqueness: true
  validates :date, presence: true
end