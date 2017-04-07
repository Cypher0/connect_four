require_relative 'lib/connect_4'

puts "Welcome to Connect Four!\nPlayer 1(black), enter your name:"
one = gets.chomp
puts 'Player 2(white), enter your name:'
two = gets.chomp
game = ConnectFour.new(two, one)
game.play
