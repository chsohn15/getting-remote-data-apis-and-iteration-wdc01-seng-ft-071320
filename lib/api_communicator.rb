require 'rest-client'
require 'json'
require 'pry'

def web_request
  response_string = RestClient.get('http://swapi.dev/api/people')
  response_hash = JSON.parse(response_string)
end

def find_character_info(character_name)
  character1 = web_request["results"].find do |character|
    character["name"].downcase == character_name
  end
end

def get_character_movies_from_api(character_info)
  #make the web request
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.

  urls = character_info["films"].collect do |url|
      response_string = RestClient.get(url)
      response_hash = JSON.parse(response_string)
  end
end

def print_movies(films)
  all_films = films.map do |film|
    film["title"]
  end
  print all_films

  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  character_info = find_character_info(character)
  films = get_character_movies_from_api(character_info)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
