require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ""
    10.times { @letters << ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word].upcase
    @grid = params[:grid]

    # checar se a palavra está na grade gerada
      # verifica se cada letra da palavra aparece menos vezes na palavra do que no grid
    valid_in_grid = @word.chars.all? { |letter| @word.count(letter) <= @grid.count(letter) }

    #fazer a requisicao para a URL
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    response = open(url).read
    
    #fazer o Parse
    parsed = JSON.parse(response)
    
    #checar se a palavra existe no dicionário
    valid_in_dict = parsed["found"]
    
    #calcula a pontuacao
    if valid_in_dict && valid_in_grid
      @score = @word.size * 100
    else
      @score = 0
    end
  end
end
