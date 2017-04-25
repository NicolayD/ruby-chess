require_relative 'chess'

game = Chess.new

game.show_board

#=begin

#until game.end?
while true
	game.choose_piece

	game.move

	game.swap_players

	game.show_board

end
	#game.end?
#end
#=end