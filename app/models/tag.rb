class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :exercises, through: :taggings, source: :tagable, source_type: 'Exercise'

  has_many :quotation_taggings
  has_many :quotations, through: :quotation_taggings
  has_many :doctrine_taggings
  has_many :doctrines, through: :doctrine_taggings

  validates :name, uniqueness: true
end
