class Exercise < ActiveRecord::Base
  belongs_to :user
  has_many :e_answers, through: :e_questions
  has_many :e_questions, dependent: :destroy
  has_many :rehearsals
  has_many :exercise_taggings
  has_many :tags, through: :exercise_taggings
  accepts_nested_attributes_for :rehearsals
  accepts_nested_attributes_for :e_questions,
                                reject_if: ->(a) { a[:question].blank? },
                                allow_destroy: true
  validates :title, presence: true
  validates :general_description, presence: true
  validate :maximum_number_of_e_questions

  def rehearsals_for_user(user)
    rehearsals.where(user: user)
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).exercises
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  def maximum_number_of_e_questions
    errors.add(:base, 'You may only add a maximum of 7 questions
               to an exercise at this time. In the future, we may
               add a feature to have additional questions. Contact us
               if this is an important feature
               to you.') unless e_questions.length <= 7
  end
end
