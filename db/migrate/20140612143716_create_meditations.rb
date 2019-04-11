class CreateMeditations < ActiveRecord::Migration
  def change
    create_table :meditations do |t|
      t.string :title
      t.text :passage

      t.timestamps
    end
  end
end
