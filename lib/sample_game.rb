require_relative 'chess.rb'

game = Game.new

game.show_board


p game.board[7][1].possible_moves game.board
p game.board[7][1].is_a? Pawn

=begin

until game.end?

	puts 'Which piece do you want to move?'
	from = gets.chomp

	puts 'Where do you want to move it?'
	to = gets.chomp

	game.move from,to

	game.swap_players

	game.show_board

	game.end?
end
=end