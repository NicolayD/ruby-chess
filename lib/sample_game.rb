require_relative 'chess.rb'

game = Game.new

game.show_board

until game.end?

	game.choose_piece

	puts 'Where do you want to move it?'
	finish = gets.chomp

	game.move game.current_piece_index,finish

	game.swap_players

	game.show_board

	game.end?
end