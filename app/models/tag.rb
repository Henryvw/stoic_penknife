# frozen_string_literal: true

class Tag < ActiveRecord::Base
  has_many :exercise_taggings
  has_many :exercises, through: :exercise_taggings
  has_many :quotation_taggings
  has_many :quotations, through: :quotation_taggings
  has_many :doctrine_taggings
  has_many :doctrines, through: :doctrine_taggings

  validates :name, uniqueness: true
  # TODO: write a test for this, you can use the shoulda-matchers gem,
  # it'll give you some handy one-liners for rspec tests.
  # Look in their source code to find out how the one-liner
  # is actually testing the code
  # besides this I would also make sure that either the validation
  # doesn't care about the letter casing or write another one that
  # downcases everything, or throws an error if not downcased
end
