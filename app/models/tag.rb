class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :exercises, through: :taggings, source: :tagable, source_type: 'Exercise'
  has_many :quotations, through: :taggings, source: :tagable, source_type: 'Quotation'
  has_many :doctrines, through: :taggings, source: :tagable, source_type: 'Doctrine'

  validates :name, uniqueness: true
end
