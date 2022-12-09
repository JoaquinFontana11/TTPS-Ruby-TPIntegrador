class CreateTurns < ActiveRecord::Migration[7.0]
  def change
    create_table :turns do |t|
      t.date :date
      t.time :hour
      t.integer :state
      t.string :reason
      t.string :comment, null: true

      t.timestamps
    end
  end
end
