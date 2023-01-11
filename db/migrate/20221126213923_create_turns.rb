class CreateTurns < ActiveRecord::Migration[7.0]
  def change
    create_table :turns do |t|
      t.date :date, null: false
      t.time :hour, null: false
      t.integer :state, null: false
      t.string :reason, null: false
      t.string :comment, null: true

      t.timestamps
    end
  end
end
