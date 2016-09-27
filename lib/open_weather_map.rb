require 'unirest'

class OpenWeatherMap
  BASE_URL = "http://api.openweathermap.org/data/2.5/weather"
  API_KEY = ENV['OPEN_WEATHER_MAP_API_KEY']

  def initialize(zip_code: nil, country_code: nil, lat: nil, lon: nil)
    @zip_code = zip_code
    @country_code = (country_code && country_code != "") ? country_code : 'us'
    @lat = lat
    @lon = lon
  end

  # api.openweathermap.org/data/2.5/weather?zip={zip code},{country code}
  # api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}
  def weather
    begin
      weather = if (@zip_code && @zip_code != "")
        Unirest.get(BASE_URL, parameters: { zip: "#{@zip_code},#{@country_code}", appid: API_KEY })
      else
        Unirest.get(BASE_URL, parameters: { lat: @lat, lon: @lon, appid: API_KEY })
      end

      # something like {"id"=>802, "main"=>"Clouds", "description"=>"scattered clouds", "icon"=>"03n"}
      weather.body["weather"][0]
    rescue
      { "main" => "Error", "description" => "there was an error" }
    end
  end
end
