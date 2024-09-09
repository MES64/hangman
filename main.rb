# frozen_string_literal: true

require_relative 'lib/executioner'
require_relative 'lib/hangman'

exec = Executioner.new
p exec
hm = Hangman.new(exec.word_length)
puts hm

%w[a e i o u].each do |guess|
  exec.update_hangman(hm, guess)
  puts hm
end
