class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :role
      # t.belongs_to :branch_offices, null: true, index: true, foreign_key: true

      t.timestamps
    end
  end
end
