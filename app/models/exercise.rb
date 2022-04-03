class Exercise < ActiveRecord::Base
  # Include Taggable methods via the Taggable Concern Module
  include Taggable

  belongs_to :user
  has_many :answers, through: :questions
  has_many :questions, dependent: :destroy
  has_many :rehearsals

  has_many :taggings, as: :tagable
  has_many :tags, through: :taggings

  accepts_nested_attributes_for :rehearsals
  accepts_nested_attributes_for :questions,
                                reject_if: ->(a) { a[:inquiry].blank? },
                                allow_destroy: true
  validates :title, presence: true
  validates :general_description, presence: true
  validates :questions, presence: true
  validate :maximum_number_of_questions
  has_one_attached :icon

  def rehearsals_for_user(user)
    rehearsals.where(user:)
  end

  def maximum_number_of_questions
    return errors.add(
      :base,
      'You may only add a max of 7 questions.'
    ) unless questions.length <= 7
  end
end
