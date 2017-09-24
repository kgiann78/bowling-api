class AddPinsToFrame < ActiveRecord::Migration[5.1]
  def change
    add_column :frames, :pins, :integer
  end
end
