class Tag < ActiveRecord::Base
  belongs_to :taggable, polymorphic: true
  validates :name, uniqueness: true

  def self.find_doctrines
    doctrines_active_record_relation = Tag.where(taggable_type: "Doctrine")
    array_of_doctrines = doctrines_active_record_relation.records
    array_of_doctrines
  end

  def self.find_exercises
    exercises_active_record_relation = Tag.where(taggable_type: "Exercise")
    array_of_exercises = exercises_active_record_relation.records
    array_of_exercises
  end
end
