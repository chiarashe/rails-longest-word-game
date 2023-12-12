require "json"
require "open-uri"

url = "https://wagon-dictionary.herokuapp.com/"
user_serialized = URI.open(url).read
user = JSON.parse(user_serialized)

class GamesController < ApplicationController
  def new
    @letters =  ("A".."Z").to_a.sample(10)
  end

  def score
    @word = params[:word].upcase!
    @letters = params[:letters]
    @exist = check_language
    @uses_words =  check_words
  end

  def check_language
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    user_serialized = URI.open(url).read
    user = JSON.parse(user_serialized)
    user['found']
  end

  def check_words
    @word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter) }
  end
end

def answer
  if @exist && @uses_words
    return "Congrats #{@word} is a valid word!!"
  elsif @uses_words
    return "The word #{@word} does not seem to be an english word"
  else
    return "please use the letters proposed #{@letters}"
  end
end
