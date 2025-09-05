{
  :schema => {
    "$schema" => "http://www.archivesspace.org/archivesspace.json",
    "type" => "object",
    "uri" => "/temp_headers",
    "properties" => {
      "uri" => {
        "type" => "string",
        "required" => false},
      "show_header" => {"type" => "boolean"},
      "notice_date" => {"type" => "date", "minLength" => 1, "default" => "1-1-2025"},
      "maintenance_start" => {"type" => "date-time", "default" => "1-1-2025"},
      "maintenance_end" => {"type" => "date-time", "default" => "1-1-2025"},
      "maintenance_message" => {"type" => "string", "maxLength" => 65000}
    },

    "additionalProperties" => false,
  },
}
