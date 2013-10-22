class Lesson < ActiveRecord::Base
  attr_accessible :title, :date

  has_many :key_concepts, :dependent => :destroy

  validates :title, presence: true
end