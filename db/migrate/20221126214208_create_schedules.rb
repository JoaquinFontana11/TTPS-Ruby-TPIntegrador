class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.time :mondayInit, null: false
      t.time :mondayFinish, null: false

      t.time :tuesdayInit, null: false
      t.time :tuesdayFinish, null: false

      t.time :wednesdayInit, null: false
      t.time :wednesdayFinish, null: false

      t.time :thursdayInit, null: false
      t.time :thursdayFinish, null: false

      t.time :fridayInit, null: false
      t.time :fridayFinish, null: false

      t.time :saturdayInit, null: false
      t.time :saturdayFinish, null: false

      t.time :sundayInit, null: false
      t.time :sundayFinish, null: false

      t.timestamps
    end
  end
end
