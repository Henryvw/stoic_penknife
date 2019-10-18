class Exercise < ActiveRecord::Base
  belongs_to :user
  has_many :answers, through: :questions
  has_many :questions, dependent: :destroy
  has_many :rehearsals
  has_many :tags, as: :tagable
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

  def maximum_number_of_questions
    return errors.add(
      :base,
      'You may only add a max of 7 questions.'
    ) unless questions.length <= 7
  end
end
