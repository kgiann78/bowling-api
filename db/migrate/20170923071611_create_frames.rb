class CreateFrames < ActiveRecord::Migration[5.1]
  def change
    create_table :frames do |t|
      t.integer :number
      t.integer :tries
      t.integer :score
      t.references :player, foreign_key: true

      t.timestamps
    end
  end
end
