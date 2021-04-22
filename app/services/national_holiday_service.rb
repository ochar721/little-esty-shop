class NationalHolidayService
  def self.conn
    Faraday.new(
      url: "https://date.nager.at"
    )
  end

  def self.get_data
    response = conn.get('/Api/v2/NextPublicHolidays/US')
    holidays = JSON.parse(response.body, symbolize_names: true)
    holidays[0..2].map do |info|
      NationalHoliday.new(info)
    end
  end
end
