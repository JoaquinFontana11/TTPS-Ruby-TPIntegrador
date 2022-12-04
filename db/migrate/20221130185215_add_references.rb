class AddReferences < ActiveRecord::Migration[7.0]
  def change
    # ------- Referencias a Usuarios -------
    add_reference :users, :branch_offices , index: true, foreign_key: true
    rename_column :users, :branch_offices_id, :branch_office_id 

    add_reference :users, :turns, index: true, foreign_key: true
    rename_column :users, :turns_id, :turns_attended_id

    # ------- Referencias a Turnos -------
    add_reference :turns, :branch_office, index: true, foreign_key: true



    add_reference :turns, :users, index: {unique: true}, foreign_key: true
    rename_column :turns, :users_id, :patient_id

    # ------- Referencias a Sucursales -------
    add_reference :branch_offices , :schedules , index: {:unique =>  true }, foreign_key: true
    rename_column :branch_offices, :schedules_id, :schedule_id

    # ------- Referencias a Horarios -------
    add_reference :schedules , :branch_offices , index: {:unique =>  true }, foreign_key: true
    rename_column :schedules, :branch_offices_id, :branch_office_id

  end
end
