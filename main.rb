# frozen_string_literal: true

require_relative 'lib/hangman'

length = 5
hm = Hangman.new(length)
puts hm

8.times do |_|
  hm.guessed_word[rand(5)] = 'e'
  hm.wrong_letters << 'p'
  puts hm
end
