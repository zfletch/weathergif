# Weathergif 

Shows an animated gif related to the weather of the location of your IP address.

[Try it.](https://weathergif.herokuapp.com/)

## How to run locally

- (requires Ruby)
- get an OpenWeatherMap API key [here](http://openweathermap.org/appid)
- add the API key to `env.development`
- `gem install bundler`
- `bundle install`
- `bundle exec rackup config.ru`
