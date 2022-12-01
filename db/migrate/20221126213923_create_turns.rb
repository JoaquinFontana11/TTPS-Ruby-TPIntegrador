class CreateTurns < ActiveRecord::Migration[7.0]
  def change
    create_table :turns do |t|
      t.date :date
      t.time :hour
      t.integer :state
      t.string :reason
      t.string :comment, null: true
      # t.belongs_to :user, null: false, index: true ,foreign_key: "client_turn"
      # t.belongs_to :user, null: true, index: true, foreign_key: "staff_attend"
      # t.belongs_to :branch_offices, null:false, index: true ,foreign_key:true

      t.timestamps
    end
  end
end
