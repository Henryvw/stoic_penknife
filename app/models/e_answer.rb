# frozen_string_literal: true

class EAnswer < ActiveRecord::Base
  belongs_to :e_question
  belongs_to :rehearsal
  # validates_that_it_has_an_e_question"
  # scope :visible_to, -> (user) { where(user_id: user.id)}
end
