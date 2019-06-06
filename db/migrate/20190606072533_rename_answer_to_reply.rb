class RenameAnswerToReply < ActiveRecord::Migration[5.2]
  def change
    rename_column :answers, :answer, :reply
  end
end
