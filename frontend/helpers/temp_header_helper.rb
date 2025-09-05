module TempHeaderHelper

  def self.get_header
    JSONModel(:temp_header).find(1)
  end

  def self.short_date(date)
    begin
      parsed = Date.strptime(date, '%Y-%m-%d')
      parsed.strftime('%-m-%-d-%Y')
    rescue
      ""
    end
  end

  def self.long_date(date)
    begin
      parsed = Date.strptime(date, '%Y-%m-%d %H:%M:%S')
      parsed.strftime("%A, %B %e")
    rescue
      ""
    end
  end

  def self.long_time(time)
    begin
      parsed = DateTime.strptime(time, '%Y-%m-%d %H:%M:%S')
      parsed.strftime("%l:%M%p EST")
    rescue
      ""
    end
  end
end
