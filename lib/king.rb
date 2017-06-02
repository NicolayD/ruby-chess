require_relative 'moves'

class King
	include Moves
	attr_accessor :symbol, :colour, :position, :possible_moves

	def initialize colour,position
		@colour = colour
		@position = position			# The position is going to look like [5,6] which represents the 5 row and 6 column
		if @colour == :white
			@symbol = "\u2654"
		elsif @colour == :black
			@symbol = "\u265A"
		end
		
		@possible_moves = []
	end

	def possible_moves board,position=self.position
		hor = position[0].to_i
		ver = position[1].to_i
		@possible_moves = []	# I have to refactor this to make it less cluttered.

		@possible_moves.push [hor+1,ver] if hor < 8 && not_ally?(board,hor+1,ver)
		@possible_moves.push [hor,ver+1] if ver < 8 && not_ally?(board,hor,ver+1)
		@possible_moves.push [hor+1,ver+1] if hor < 8 && ver < 8 && not_ally?(board,hor+1,ver+1)
		@possible_moves.push [hor-1,ver] if hor > 1 && not_ally?(board,hor-1,ver)
		@possible_moves.push [hor,ver-1] if ver > 1 && not_ally?(board,hor,ver-1)
		@possible_moves.push [hor-1,ver-1] if hor > 1 && ver > 1 && not_ally?(board,hor-1,ver-1)
		@possible_moves.push [hor-1,ver+1] if hor > 1 && ver < 8 && not_ally?(board,hor-1,ver+1)
		@possible_moves.push [hor+1,ver-1] if hor < 8 && ver > 1 && not_ally?(board,hor+1,ver-1)
		@possible_moves
	end
end