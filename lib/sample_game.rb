require_relative 'chess.rb'

game = Game.new

until game.end?

	game.show_board

	puts "Which piece do you want to move?"

	game.choose_piece

	puts 'Where do you want to move it?'
	finish = gets.chomp

	game.move game.current_piece_index,finish

	game.swap_players
end