class AddTaggableToTag < ActiveRecord::Migration[5.2]
  def change
    add_reference :tags, :taggable, polymorphic: true
  end
end
