require 'tzinfo'

module TempHeaderHelper

  def self.get_header
    JSONModel(:temp_header).find(1)
  end

  def self.short_date(date)
    begin
      parsed = Date.strptime(date, '%Y-%m-%d')
      parsed.strftime('%-m-%-d-%Y')
    rescue
      ''
    end
  end

  def self.long_date(date)
    begin
      parsed = Date.strptime(date, '%Y-%m-%d %H:%M:%S')
      parsed.strftime('%A, %B %e')
    rescue
      ''
    end
  end

  def self.long_time(time)
    begin
      timezone = TZInfo::Timezone.get('America/New_York')
      parsed = Time.strptime(time, '%Y-%m-%d %H:%M:%S')
      parsed_time_tz = timezone.utc_to_local(parsed)
      parsed_time_tz.strftime('%l:%M%p %Z')
    rescue
      ''
    end
  end
end
