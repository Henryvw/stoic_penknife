class EAnswer < ActiveRecord::Base
  belongs_to :question
  belongs_to :rehearsal
  # validates_that_it_has_an_question"
  # scope :visible_to, -> (user) { where(user_id: user.id)}
end
