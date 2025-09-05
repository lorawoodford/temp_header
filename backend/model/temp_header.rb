class TempHeader < Sequel::Model(:temp_header)
  include ASModel

  corresponds_to JSONModel(:temp_header)

  set_model_scope :global

end
