class Quotation < ActiveRecord::Base
  has_many :quotation_taggings
  has_many :tags, through: :quotation_taggings

  def self.tagged_with(name)
    Tag.find_by_name!(name).quotations # This default ActiveRecord method
    # activates two sql queries,
    # first one to find all tags by name,
    # second one to find the tags quotations
  end

  def self.find_quotations_with(multiple_tags)
    quotations = []
    multiple_tags.each do |tag|
      quotations += Tag.find_by_name!(tag.name).quotations
    end
    quotations
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
