class Rehearsal < ActiveRecord::Base
  belongs_to :exercise
  belongs_to :user
  has_many :questions, through: :exercises
  has_many :e_answers, dependent: :destroy
  accepts_nested_attributes_for :e_answers
  accepts_nested_attributes_for :questions
end
