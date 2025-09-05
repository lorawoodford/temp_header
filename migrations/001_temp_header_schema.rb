Sequel.migration do
  up do

    create_table(:temp_header) do
      primary_key :id

      Integer :lock_version, :default => 0, :null => false

      Integer :show_header, default: 0
      DateTime :notice_date
      DateTime :maintenance_start
      DateTime :maintenance_end
      TextField :maintenance_message

      apply_mtime_columns
    end

  end

  down do
    drop_table(:temp_header)
  end

end
