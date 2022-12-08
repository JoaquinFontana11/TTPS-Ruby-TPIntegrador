class AddReferences < ActiveRecord::Migration[7.0]
  def change
    # ------- Referencias a Usuarios -------
    add_reference :users, :branch_offices , index: true, foreign_key: true
    rename_column :users, :branch_offices_id, :branch_office_id 

    # ------- Referencias a Turnos -------
    add_reference :turns, :branch_offices , index: true, foreign_key: true
    rename_column :turns, :branch_offices_id, :branch_office_id 

    add_reference :turns, :client, index: true, foreign_key: {to_table: "users"}

    add_reference :turns, :users, index: true, foreign_key: true
    rename_column :turns, :users_id, :staff_attended_id

    # ------- Referencias a Sucursales -------
    add_reference :branch_offices , :schedules , index: {:unique =>  true }, foreign_key: true
    rename_column :branch_offices, :schedules_id, :schedule_id

    # ------- Referencias a Horarios -------
    # add_reference :schedules , :branch_offices , index: {:unique =>  true }, foreign_key: true
    # rename_column :schedules, :branch_offices_id, :branch_office_id

  end
end
