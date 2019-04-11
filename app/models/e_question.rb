class EQuestion < ActiveRecord::Base
  belongs_to :exercise
  has_many :e_answers, dependent: :destroy
  accepts_nested_attributes_for :e_answers,
                                reject_if: ->(a) { a[:answer].blank? },
                                allow_destroy: true
end
