class RenameQuestionToInquiry < ActiveRecord::Migration[5.2]
  def change
    rename_column :questions, :question, :inquiry
  end
end
