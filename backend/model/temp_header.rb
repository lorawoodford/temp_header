class TempHeader < Sequel::Model(:temp_header)
  include ASModel
  corresponds_to JSONModel(:temp_header)

  set_model_scope :global

  def validate
    validate_single_record
    validate_date_presence
    validate_date
  end

  def validate_single_record
    record_count = TempHeader.all.count

    unless record_count == 0
      # if we have an existing record, we'd better be updating that one record
      first_record = TempHeader.first

      if self.id.nil? || first_record.id != self.id
        errors.add(:base, 'Cannot have more than one record in temp_header table.')
      end
    end
  end

  def validate_date_presence
    if self.show_header
      date_type_atts = [:notice_date, :maintenance_start, :maintenance_end]
      nil_dates = self.to_hash.select { |key, _value| date_type_atts.include?(key) }.filter { |_key, value| value.nil? }
      if !nil_dates.empty?
        nil_dates.each do |k, v|
          errors.add(k, :all_dates_required)
        end
      end
    end
  end

  def validate_date
    if self.maintenance_start && self.maintenance_end
      if self.maintenance_end < self.maintenance_start
        errors.add(:maintenance_end, "must not be before begin")
      end
    end
  end

end
