class Question < ActiveRecord::Base
  belongs_to :exercise
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers,
                                reject_if: ->(a) { a[:reply].blank? },
                                allow_destroy: true
end
