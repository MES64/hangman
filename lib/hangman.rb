# frozen_string_literal: true

# Hangman stores information about the 'paper' game state: the word so far and incorrect letters
# Methods include to_s, and methods to update the word so far and the incorrect letters
# Constants used are the maximum mmistakes allowed and the draw order for the hangman drawing
class Hangman
  MAX_MISTAKES = 8
  DRAW_ORDER = [
    { char: 'o', row: 2, col: 4 },
    { char: '|', row: 3, col: 4 },
    { char: '/', row: 3, col: 3 },
    { char: '\\', row: 3, col: 5 },
    { char: '/', row: 4, col: 3 },
    { char: '\\', row: 4, col: 5 },
    { char: '|', row: 1, col: 4 }
  ].freeze

  private_constant :MAX_MISTAKES, :DRAW_ORDER

  attr_accessor :guessed_word, :wrong_letters

  def initialize(word_length)
    @guessed_word = Array.new(word_length, ' ')
    @wrong_letters = []
  end

  def to_s
    "\n#{print_wrong_letters}\n#{print_guessed_word}\n#{draw_hangman}\n#{print_mistakes_left}\n\n"
  end

  private

  def print_wrong_letters
    "Wrong: #{@wrong_letters.join(' ')}"
  end

  def print_guessed_word
    "#{@guessed_word.join(' ')}\n#{Array.new(@guessed_word.length, '‾').join(' ')}"
  end

  def print_mistakes_left
    "#{MAX_MISTAKES - @wrong_letters.length} mistakes left!"
  end

  def draw_hangman
    grid = Array.new(5) { Array.new(8, ' ') }
    grid << Array.new(8, '_')
    grid = draw_post(deep_copy(grid)) if @wrong_letters.length.positive?
    0.upto(@wrong_letters.length - 2) { |mistake_number| grid = draw_part(deep_copy(grid), mistake_number) }
    grid.map(&:join).join("\n")
  end

  def draw_post(grid)
    5.downto(1) { |row| grid[row][0] = '|' }
    grid[0] = ['+', '-', '-', '-', '+', ' ', ' ', ' ']
    grid
  end

  def draw_part(grid, mistake_number)
    char = DRAW_ORDER[mistake_number][:char]
    row = DRAW_ORDER[mistake_number][:row]
    col = DRAW_ORDER[mistake_number][:col]
    grid[row][col] = char
    grid
  end

  def deep_copy(grid)
    Marshal.load(Marshal.dump(grid))
  end
end
