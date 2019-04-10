# frozen_string_literal: true

class Doctrine < ActiveRecord::Base
  has_many :doctrine_taggings
  has_many :tags, through: :doctrine_taggings

  def self.tagged_with(name)
    Tag.find_by_name!(name).doctrines
  end

  def self.find_doctrines_with(multiple_tags)
    doctrines = []
    multiple_tags.each do |tag|
      doctrines += Tag.find_by_name!(tag.name).doctrines
    end
    doctrines
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end
