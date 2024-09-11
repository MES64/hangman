# frozen_string_literal: true

require_relative 'player'
require_relative 'executioner'
require_relative 'hangman'

# Game holds info about the player, the executioner, the hangman, and the result
class Game
  MAX_MISTAKES = 8

  def initialize
    @player = Player.new
    @executioner = Executioner.new
    @hangman = Hangman.new(@executioner.word_length, MAX_MISTAKES)
    @result = nil
  end

  def play
    puts @hangman
    play_turn while @result.nil?
    puts @result
  end

  private

  def play_turn
    guess = @player.user_input(@hangman)
    @executioner.update_hangman(@hangman, guess)
    puts @hangman
    check_game_over
  end

  def check_game_over
    if @hangman.wrong_letters.length == MAX_MISTAKES
      @result = 'Too late! The executioner wins!'
    elsif @hangman.guessed_word.none?(' ')
      @result = 'You guessed the word! You win!'
    end
  end
end
