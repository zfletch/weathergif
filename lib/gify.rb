require 'unirest'

class Gify
  BASE_URL = "https://api.giphy.com/v1/gifs/translate"
  API_KEY = ENV['GIFY_API_KEY']

  def initialize(text: nil)
    @text = text
  end

  # http://api.giphy.com/v1/gifs/translate?s=superman&api_key=dc6zaTOxFJmzC
  def translate
    begin
      gify = Unirest.get(BASE_URL, parameters: { s: @text, api_key: API_KEY, rating: 'pg' })
      gify.body["data"]["images"]["original"]["url"]
    rescue
      "http://i.giphy.com/emWySpOLFLUAM.gif"
    end
  end
end
