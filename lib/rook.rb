require_relative 'moves'
# Class for Rook objects of both colours
class Rook
	include Moves
	attr_accessor :symbol, :colour, :position, :possible_moves

  # The position will look like [5,6] which represents row 5 and column 6

	def initialize(colour, position)
		@colour = colour
		@position = position
		if @colour == :white
			@symbol = "\u2656"
		elsif @colour == :black
			@symbol = "\u265C"
		end
		@possible_moves = []
	end

	def possible_moves(board, position = self.position)
		hor = position[0].to_i
		ver = position[1].to_i
		@possible_moves = []

    move_right(board, @possible_moves, hor, ver)
    move_left(board, @possible_moves, hor, ver)
    move_up(board, @possible_moves, hor, ver)
    move_down(board, @possible_moves, hor, ver)

		@possible_moves
	end
end
