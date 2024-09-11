# frozen_string_literal: true

# Player can input either a letter guess or to save
class Player
  VALID_INPUT = (('a'..'z').to_a << 'save').freeze
  VALID_FILE_NAME_CHARS = (('a'..'z').to_a.concat(('A'..'Z').to_a, ('0'..'9').to_a) << '_').freeze
  VALID_YES_NO = %w[y n].freeze

  private_constant :VALID_INPUT, :VALID_FILE_NAME_CHARS, :VALID_YES_NO

  def user_input(game)
    input = receive_input
    while input == 'save'
      save(game)
      input = receive_input
    end
    input
  end

  private

  def receive_input
    puts 'Enter your letter guess. To save the game type: save'
    puts 'Input repeats until valid (a-z, A-Z, save)'
    input = gets.chomp.downcase until input && VALID_INPUT.include?(input)
    input
  end

  def save(game)
    puts 'Enter the file name for your save. E.g. my_game2'
    puts 'Input repeats until valid (a-z, A-Z, 0-9, _)'
    file_name = gets.chomp until file_name && valid_name?(file_name)
    file_path = "./game_saves/#{file_name}.json"
    File.open(file_path, 'w') { |file| file.puts game.serialize } if proceed_save?(file_path)
  end

  def proceed_save?(file_path)
    return true unless File.exist?(file_path)

    puts 'This file already exists. Overwrite?'
    puts 'Input repeats until valid (y/n)'
    save_decision = gets.chomp.downcase until save_decision && VALID_YES_NO.include?(save_decision)
    save_decision == 'y'
  end

  def valid_name?(file_name)
    file_name.chars.all? { |char| VALID_FILE_NAME_CHARS.include?(char) }
  end
end
