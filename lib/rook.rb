require_relative 'moves'

class Rook
	include Moves
	attr_accessor :symbol, :colour, :position, :possible_moves

	def initialize colour,position
		@colour = colour
		@position = position # The position is going to look like [5,6] which represents the 5 row and 6 column
		if @colour == :white
			@symbol = "\u2656"
		elsif @colour == :black
			@symbol = "\u265C"
		end

		@possible_moves = []
	end

	def possible_moves board,position=self.position
		hor = position[0].to_i
		ver = position[1].to_i
		@possible_moves = []

		right = ver + 1
		if right < 8
			while right <= 8 && not_ally?(board,hor,right)
				@possible_moves.push [hor,right]
				break if enemy?(board,hor,right)
				right += 1
			end
		end

		left = ver - 1
		if left > 0
			while left > 0 && not_ally?(board,hor,left)
				@possible_moves.push [hor,left]
				break if enemy?(board,hor,left)
				left -= 1
			end
		end

		up = hor - 1
		if up > 0
			while up > 0 && not_ally?(board,up,ver)
				@possible_moves.push [up,ver]
				break if enemy?(board,up,ver)
				up -= 1
			end
		end

		down = hor + 1
		if down <= 8
			while down <= 8 && not_ally?(board,down,ver)
				@possible_moves.push [down,ver]
				break if enemy?(board,down,ver)
				down += 1
			end
		end

		@possible_moves
	end
end
