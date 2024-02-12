require "json"
require "open-uri"

class GamesController < ApplicationController
  LETTERS = []

  def new
    LETTERS.clear
    10.times {LETTERS.push(('a'..'z').to_a.sample) }
    @letters = LETTERS
  end

  def score
    @answer = params[:answer]
    @lettersArray = LETTERS

    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    word_serialized = URI.open(url).read
    @word = JSON.parse(word_serialized)

    if @word["found"]
      @word = @word["word"].split("")
      if (@word - @lettersArray).empty?
        @result = "Congratulations! #{@answer} is a valid English word"
      else
        @result = "Sorry, but #{@answer} can't be built out of #{@lettersArray.join(", ")}"
      end
    else
      @result = "Sorry, but #{@answer} does not seem to be a valid English word"
    end
  end
end
