class AddCityToRehearsal < ActiveRecord::Migration[5.0]
  def change
    add_column :rehearsals, :city, :string
  end
end
