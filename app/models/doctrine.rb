class Doctrine < ActiveRecord::Base
  has_many :tags, as: :taggable

  def self.find_doctrines_with(multiple_tags)
    binding.pry
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
