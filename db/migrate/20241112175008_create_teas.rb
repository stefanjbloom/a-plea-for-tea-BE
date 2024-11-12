class CreateTeas < ActiveRecord::Migration[7.1]
  def change
    create_table :teas do |t|
      t.string :title
      t.string :description
      t.integer :temperature
      t.integer :brewtime

      t.timestamps
    end
  end
end
