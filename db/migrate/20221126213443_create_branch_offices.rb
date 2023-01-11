class CreateBranchOffices < ActiveRecord::Migration[7.0]
  def change
    create_table :branch_offices do |t|
      t.string :name, unique: true, null: false
      t.string :direc, null: false
      t.string :tel, null: false

      t.timestamps
    end
  end
end
