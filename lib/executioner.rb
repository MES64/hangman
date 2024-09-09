# frozen_string_literal: true

# Executioner holds the secret word
# It has method for choosing the word and updating hangman
# Constants for the word length range and the dictionmary file path
class Executioner
  MIN_WORD_LENGTH = 5
  MAX_WORD_LENGTH = 12
  DICT_FILE_PATH = './dictionary.txt'

  private_constant :MIN_WORD_LENGTH, :MAX_WORD_LENGTH, :DICT_FILE_PATH

  def initialize
    @word = select_word
  end

  def update_hangman(hangman, guess)
    if @word.include?(guess)
      @word.each_with_index { |letter, idx| hangman.guessed_word[idx] = guess if guess == letter }
    else
      hangman.wrong_letters << guess
    end
  end

  def word_length
    @word.length
  end

  private

  def select_word
    dict = File.open(DICT_FILE_PATH, 'r') { |file| file.readlines(chomp: true) }
    dict = dict.select { |word| (MIN_WORD_LENGTH..MAX_WORD_LENGTH).include?(word.length) }
    dict.sample.chars
  end
end
