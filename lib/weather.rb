require 'open_weather'
require 'httparty'

class Weather
  include HTTParty

  def self.get_weather_for_location(location)
    HTTParty.get("http://api.openweathermap.org/data/2.5/weather?q=#{location}&appid=a3d9eb01d4de82b9b8d0849ef604dbed&units=metric")
  end

end
