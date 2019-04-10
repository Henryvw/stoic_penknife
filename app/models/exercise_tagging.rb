# frozen_string_literal: true

class ExerciseTagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :exercise
end
