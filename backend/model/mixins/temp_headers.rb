module TempHeaders

  def self.included(base)
    base.include(Relationships)
    base.define_relationship(:name => :temp_header,
                             :json_property => 'temp_headers',
                             :contains_references_to_types => proc {[TempHeader]})
  end

end
