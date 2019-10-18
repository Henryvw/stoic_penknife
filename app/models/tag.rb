class Tag < ActiveRecord::Base
  belongs_to :tagable, polymorphic: true

  has_many :quotation_taggings
  has_many :quotations, through: :quotation_taggings
  has_many :doctrine_taggings
  has_many :doctrines, through: :doctrine_taggings

  validates :name, uniqueness: true
end
