class AddRehearsalIdToEAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :rehearsal_id, :integer
  end
end
