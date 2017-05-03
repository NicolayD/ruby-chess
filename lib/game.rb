require_relative 'chess'

game = Chess.new

#=begin

#until game.end?
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

	game.swap_players

end
	#game.end?
#end
#=end

# Have to refactor queen and bishop moves to include the border tiles.