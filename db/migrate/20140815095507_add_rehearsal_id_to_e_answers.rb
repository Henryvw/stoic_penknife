class AddRehearsalIdToEAnswers < ActiveRecord::Migration
  def change
    add_column :e_answers, :rehearsal_id, :integer
  end
end
