require_relative 'chess'

game = Chess.new

while true
	game.show_board

	if game.check?
		puts 'Check!'
	end

	game.choose_piece

	game.move

	if game.checkmate
		puts "Checkmate! #{game.current_player} wins."
		game.show_board
		exit
	end

	if game.draw?
		puts "Draw."
		game.show_board
		exit
	end

	game.swap_players
end