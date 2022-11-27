class CreateBranchOffices < ActiveRecord::Migration[7.0]
  def change
    create_table :branch_offices do |t|
      t.string :name
      t.string :direc
      t.string :tel
      t.references :schedule, null: false, foreign_key: true
      t.references :turn, null: false, foreign_key: true

      t.timestamps
    end
  end
end
