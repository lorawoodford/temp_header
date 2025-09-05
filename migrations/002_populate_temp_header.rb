Sequel.migration do
  up do
    $stderr.puts("Adding values Temp Header table")

    self[:temp_header].insert(show_header: 0,
                              notice_date: nil,
                              maintenance_start: nil,
                              maintenance_end: nil,
                              maintenance_message: nil,
                              create_time: Time.now,
                              system_mtime: Time.now,
                              user_mtime: Time.now,
                              created_by: 'admin')
  end

  down do
    self[:temp_header].delete
  end

end
