require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @random_letters = ('a'..'z').to_a.sample(10).join(', ')
  end

  def score
    @user_letters = params[:word]
    @random_letters = params[:random_letters]
    @first_condition = @user_letters.chars.all? { |letter| @user_letters.count(letter) <= @random_letters.count(letter) }
    if @first_condition
      response = open("https://wagon-dictionary.herokuapp.com/#{@user_letters}")
      json = JSON.parse(response.read)
      @second_condition = json['found']
    else
      false
    end
    @first_condition && @second_condition ? @score = true : @score = false
  end
end
