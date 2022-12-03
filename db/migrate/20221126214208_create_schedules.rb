class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.time :mondayInit
      t.time :mondayFinish

      t.time :tuesdayInit
      t.time :tuesdayFinish

      t.time :wednesdayInit
      t.time :wednesdayFinish

      t.time :thursdayInit
      t.time :thursdayFinish

      t.time :fridayInit
      t.time :fridayFinish

      t.time :saturdayInit
      t.time :saturdayFinish

      t.time :sundayInit
      t.time :sundayFinish

      t.timestamps
    end
  end
end
