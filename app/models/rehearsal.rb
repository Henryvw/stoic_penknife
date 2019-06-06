class Rehearsal < ActiveRecord::Base
  belongs_to :exercise
  belongs_to :user
  has_many :questions, through: :exercises
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers
  accepts_nested_attributes_for :questions
end
