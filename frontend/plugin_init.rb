require_relative 'helpers/temp_header_helper'

ArchivesSpace::Application.extend_aspace_routes(File.join(File.dirname(__FILE__), "routes.rb"))

Rails.application.config.after_initialize do
  JSONModel(:temp_header)
end
