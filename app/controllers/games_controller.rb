require "open-uri"
require "json"

class GamesController < ApplicationController

  def new
    @letters = ("a".."z").to_a.sample(10).join(" ")
  end

  def score
    @word = params[:input]
    @letters = params[:letters]
    @tfletters = @word.chars.all?{ |letter| @letters.count(letter) >= @word.count(letter) }
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    @foundword = JSON.parse(open(url).read)
    if @tfletters == true
      if @foundword["found"]
        @message = "congratulations! it's a word"
      else
        @message = "nice try but not a real word"
      end
    else
      @message = "word is not part of the grid"
    end
  end
end

# The word can’t be built out of the original grid
# The word is valid according to the grid, but is not a valid English word
# The word is valid according to the grid and is an English word