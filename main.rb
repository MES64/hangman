# frozen_string_literal: true

require_relative 'lib/executioner'
require_relative 'lib/hangman'
require_relative 'lib/player'
require_relative 'lib/game'

exec = Executioner.new
p exec
hm = Hangman.new(exec.word_length)
puts hm
player = Player.new

8.times do
  player.user_input(hm)
  exec.update_hangman(hm, player.input)
  puts hm
end

p Game.new(player, exec, hm)
