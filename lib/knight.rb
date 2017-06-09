require_relative 'moves'
# Class for Knight objects of both colours
class Knight
	include Moves
	attr_accessor :symbol, :colour, :position, :possible_moves

  # The position will look like [5,6] which represents row 5 and column 6

	def initialize(colour, position)
		@colour = colour
		@position = position
		if @colour == :white
			@symbol = "\u2658"
		elsif @colour == :black
			@symbol = "\u265E"
		end
		@possible_moves = []
	end

	def possible_moves(board, position = self.position)
		hor = position[0].to_i
		ver = position[1].to_i
		@possible_moves = []

		@possible_moves.push [hor-2, ver-1] if hor > 2 && ver > 1 && not_ally?(board, hor-2, ver-1)
		@possible_moves.push [hor-2, ver+1] if hor > 2 && ver < 8 && not_ally?(board, hor-2, ver+1)
		@possible_moves.push [hor+2, ver-1] if hor < 7 && ver > 1 && not_ally?(board, hor+2, ver-1)
		@possible_moves.push [hor+2, ver+1] if hor < 7 && ver < 8 && not_ally?(board, hor+2, ver+1)
		@possible_moves.push [hor-1, ver+2] if hor > 1 && ver < 7 && not_ally?(board, hor-1, ver+2)
		@possible_moves.push [hor+1, ver+2] if hor < 8 && ver < 7 && not_ally?(board, hor+1, ver+2)
		@possible_moves.push [hor-1, ver-2] if hor > 1 && ver > 2 && not_ally?(board, hor-1, ver-2)
		@possible_moves.push [hor+1, ver-2] if hor < 8 && ver > 2 && not_ally?(board, hor+1, ver-2)
		@possible_moves
	end
end
