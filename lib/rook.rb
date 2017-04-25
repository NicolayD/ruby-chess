
class Rook
	attr_accessor :symbol, :colour, :position, :possible_moves

	def initialize colour,position
		@colour = colour
		@position = position			# The position is going to look like [5,6] which represents the 5 row and 6 column
		if @colour == :white
			@symbol = "\u2656"
		elsif @colour == :black
			@symbol = "\u265C"
		end

		@possible_moves = []
	end

	def possible_moves board,position=self.position
		hor = position[0]
		ver = position[1]
		@possible_moves = []

		right = ver + 1
		if right < 8
			right_tile = board[hor][right]
			while right < 8 && (right_tile == " " || (right_tile.respond_to?(:colour) && right_tile.colour != self.colour))
				@possible_moves.push [hor,right]
				break if right_tile.respond_to?(:colour) && right_tile.colour != self.colour
				right += 1
				right_tile = board[hor][right]
			end
		end

		left = ver - 1
		if left > 0
			left_tile = board[hor][left]
			while left > 0 && (left_tile == " " || (left_tile.respond_to?(:colour) && left_tile.colour != self.colour))
				@possible_moves.push [hor,left]
				break if left_tile.respond_to?(:colour) && left_tile.colour != self.colour
				left -= 1
				left_tile = board[hor][left]
			end
		end

		up = hor - 1
		if up > 0
			up_tile = board[up][ver]
			while up > 0 && (up_tile == " " || (up_tile.respond_to?(:colour) && up_tile.colour != self.colour))
				@possible_moves.push [up,ver]
				break if up_tile.respond_to?(:colour) && up_tile.colour != self.colour
				up -= 1
				up_tile = board[up][ver]
			end
		end

		down = hor + 1
		if down < 8
			down_tile = board[down][ver]
			while down < 8 && (down_tile == " " || (down_tile.respond_to?(:colour) && down_tile.colour != self.colour))
				@possible_moves.push [down,ver]
				break if down_tile.respond_to?(:colour) && down_tile.colour != self.colour
				down += 1
				down_tile = board[down][ver]
			end
		end

		@possible_moves
	end
end