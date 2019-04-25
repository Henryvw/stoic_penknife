class CreateRehearsals < ActiveRecord::Migration[5.2]
  def change
    create_table :rehearsals do |t|
      t.integer :tally

      t.timestamps
    end
  end
end
