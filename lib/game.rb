# frozen_string_literal: true

# Game holds info about the player, the executioner, the hangman, and the result
class Game
  def initialize(player, executioner, hangman)
    @player = player
    @executioner = executioner
    @hangman = hangman
    @result = nil
  end
end
