# frozen_string_literal: true

# Player can input either a letter guess or to save
class Player
  VALID_INPUT = (('a'..'z').to_a << 'save').freeze
  VALID_FILE_NAME_CHARS = (('a'..'z').to_a.concat(('A'..'Z').to_a, ('0'..'9').to_a) << '_').freeze

  attr_reader :input

  def initialize
    @input = nil
  end

  def user_input(hangman)
    @input = nil
    puts 'Enter your letter guess. To save the game type: save'
    save(hangman) while recieve_input == 'save'
  end

  private

  def recieve_input
    @input = gets.chomp.downcase until @input && VALID_INPUT.include?(input)
    @input
  end

  def save(hangman)
    puts "Enter the file name for your save. E.g. my_game2\nInput repeats until valid (a-z, A-Z, 0-9, _)"
    file_name = gets.chomp until file_name && valid_name?(file_name)
    file_path = "./game_saves/#{file_name}.txt"
    # Maybe check for existing name and ask if want to overwrite
    File.open(file_path, 'w') { |file| file.puts hangman.serialize }
  end

  def valid_name?(file_name)
    file_name.chars.all? { |char| VALID_FILE_NAME_CHARS.include?(char) }
  end
end
