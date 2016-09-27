require 'sinatra'
require 'geocoder'
require './lib/open_weather_map'
require './lib/gify'

class Weathergif < Sinatra::Base
  get '/' do
    # {"ip"=>"::1", "city"=>"", "region_code"=>"", "region_name"=>"", "metrocode"=>"", "zipcode"=>"", "latitude"=>"0", "longitude"=>"0", "country_name"=>"Reserved", "country_code"=>"RD"}
    @location = request.location.data rescue default_location

    @header = weather["description"]
    @text = weather["main"]
    @img = gify

    @debug = request.params["debug"] == 'y'

    erb :index
  end

  def default_location
    { "latitude" => "0", "longitude" => "0" }
  end

  def weather
    @weather ||= OpenWeatherMap.new(
      zip_code: @location["zipcode"],
      country_code: @location["country_code"],
      lat: @location["latitude"],
      lon: @location["longitude"],
    ).weather
  end

  def gify
    @gify ||= Gify.new(text: @text).translate
  end
end
