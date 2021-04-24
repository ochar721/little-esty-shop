class Holiday
  attr_reader :name,
              :date
              
  def initialize(day)
    @name = day[:name]
    @date = day[:date]
  end
end
