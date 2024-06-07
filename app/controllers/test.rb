require 'open-uri'
require "json"

def get_movie_search()
  url = URI.open("http://www.omdbapi.com/?apikey=adf1f2d7&s=harry").read
  req = JSON.parse(url)
  puts req
end

get_movie_search
