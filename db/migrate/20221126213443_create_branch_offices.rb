class CreateBranchOffices < ActiveRecord::Migration[7.0]
  def change
    create_table :branch_offices do |t|
      t.string :name
      t.string :direc
      t.string :tel
      # t.belongs_to :schedule, null: false, index: {unique: true}, foreign_key: true

      t.timestamps
    end
  end
end
