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
    .permissions([])
    .returns([200, :updated]) \
  do
    update_temp_header(params)
  end

    # update oai_config record
  # same as above, but update the single record in table
  # no matter what ID is passed in
  Endpoint.post('/temp_headers/:id')
    .description("Update the Temp Header record")
    .params(["temp_header",
             JSONModel(:temp_header),
             "The updated record",
             :body => true])
    .permissions([])
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

  # Endpoint.post('/temp_headers/:id')
  #   .description("Update a Temp Header")
  #   .params(["id", :id],
  #           ["temp_header", JSONModel(:temp_header), "The updated record", :body => true])
  #   .permissions([])
  #   .returns([200, :updated]) \
  # do
  #   handle_update(TempHeader, params[:id], params[:temp_header])
  # end

  # Endpoint.post('/temp_headers')
  #   .description("Create an Temp Header")
  #   .params(["temp_header", JSONModel(:temp_header), "The record to create", :body => true])
  #   .permissions([])
  #   .returns([200, :created]) \
  # do
  #   handle_create(TempHeader, params[:temp_header])
  # end

  # Endpoint.get('/temp_headers')
  #   .description("Get a list of Temp Headers")
  #   .params()
  #   .permissions([])
  #   .returns([200, "[(:temp_header)]"]) \
  # do
  #   handle_unlimited_listing(Enumeration)
  # end

  # Endpoint.get('/temp_headers/:id')
  #   .description("Get a Temp Header by ID")
  #   .params(["id", :id],
  #           ["resolve", :resolve])
  #   .permissions([])
  #   .returns([200, "(:temp_header)"]) \
  # do
  #   json = TempHeader.to_jsonmodel(params[:id])
  #   json_response(resolve_references(json, params[:resolve]))
  # end

  # Endpoint.delete('/temp_headers/:id')
  #   .description("Delete a Temp Header")
  #   .params(["id", :id])
  #   .permissions([])
  #   .returns([200, :deleted]) \
  # do
  #   handle_delete(TempHeader, params[:id])
  # end

end
