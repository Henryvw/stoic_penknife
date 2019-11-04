module Taggable
  extend ActiveSupport::Concern

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  # Extend Class Methods as well to any Class mixing-in the Taggable Module
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def tagged_with(name)
      relevant_model = self.name.pluralize.downcase.to_sym
      tag = Tag.find_by_name!(name)

      tag.send(relevant_model)
      # For example tag.exercises, tag.quotations, etc.
    end

    def find_me_with(multiple_tags)
      relevant_model = self.name.pluralize.downcase.to_sym
      objects_array = []
      multiple_tags.each do |tag|
        objects_array += Tag.find_by_name!(tag.name).send(relevant_model)
      end
      objects_array
    end
  end
end
