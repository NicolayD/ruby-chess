require_relative 'moves'
# Class for Bishop objects of both colours
class Bishop
	include Moves
	attr_accessor :symbol, :colour, :position

  # The position will look like [5,6] which represents row 5 and column 6

	def initialize(colour, position)
		@colour = colour
		@position = position
		if @colour == :white
			@symbol = "\u2657"
		elsif @colour == :black
			@symbol = "\u265D"
		end
		@possible_moves = []
	end

	def possible_moves(board, position=self.position)
		hor = position[0].to_i
		ver = position[1].to_i
		@possible_moves = []

    move_north_east(board, @possible_moves, hor, ver)

    move_north_west(board, @possible_moves, hor, ver)

    move_south_east(board, @possible_moves, hor, ver)

    move_south_west(board, @possible_moves, hor, ver)
    
		@possible_moves
	end
end
