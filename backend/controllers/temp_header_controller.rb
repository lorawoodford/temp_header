class ArchivesSpaceService < Sinatra::Base

  Endpoint.get('/temp_headers')
    .description("Get the Temp Header record")
    .permissions([])
    .returns([200, "(:temp_header)"]) \
  do
    handle_unlimited_listing(TempHeader)
  end

  Endpoint.post('/temp_headers')
    .description("Update the Temp Header record")
    .params(["temp_header",
             JSONModel(:temp_header),
             "The updated record",
             :body => true])
    .permissions([:administer_system])
    .returns([200, :updated]) \
  do
    update_temp_header(params)
  end

  Endpoint.post('/temp_headers/:id')
    .description("Update the Temp Header record")
    .params(["temp_header",
             JSONModel(:temp_header),
             "The updated record",
             :body => true])
    .permissions([:administer_system])
    .returns([200, :updated]) \
  do
    update_temp_header(params)
  end

  def update_temp_header(params)
    th = TempHeader.first
    json = params[:temp_header]

    th.update(:show_header     => json["show_header"],
              :notice_date         => json["notice_date"],
              :maintenance_start       => json["maintenance_start"],
              :maintenance_end          => json["maintenance_end"],
              :maintenance_message       => json["maintenance_message"]
              )

    updated_response(th, json)
  end
end
