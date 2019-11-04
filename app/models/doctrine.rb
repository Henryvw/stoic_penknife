class Doctrine < ActiveRecord::Base
  include Taggable

  has_many :taggings, as: :tagable
  has_many :tags, through: :taggings
end
