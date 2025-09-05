{
  :schema => {
    "$schema" => "http://www.archivesspace.org/archivesspace.json",
    "type" => "object",
    "uri" => "/temp_headers",

    "properties" => {
      "show_header" => {"type" => "boolean", "default" => false},
      "notice_date" => {"type" => "date"},
      "maintenance_start" => {"type" => "date-time"},
      "maintenance_end" => {"type" => "date-time"},
      "maintenance_message" => {"type" => "string", "maxLength" => 65000}
    }
  },
}
