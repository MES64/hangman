# frozen_string_literal: true

# Hangman stores information about the 'paper' game state: the word so far and incorrect letters
# Methods include to_s, and methods to update the word so far and the incorrect letters
class Hangman
  def initialize(word_length)
    @guessed_word = Array.new(word_length)
    @wrong_letters = []
  end
end
