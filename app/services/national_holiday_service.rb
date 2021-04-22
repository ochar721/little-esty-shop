class NationalHolidayService
  def self.conn
    Faraday.new(
      url: "https://date.nager.at"
    )
  end

  def self.get_data
    response = conn.get('/Api/v2/NextPublicHolidays/US')
    holidays = JSON.parse(response.body, symbolize_names: true)
    binding.pry
    holidays[0..2].map do |info|
      NationalHoliday.new(info)
    end
  end
    # response = Faraday.get("https://date.nager.at/Api/v2/NextPublicHolidays/US")
    # data = response.body
    # json = JSON.parse(data, symbolize_names: true)
    # holidays = json[0..2]
end
