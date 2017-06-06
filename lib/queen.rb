
class Queen
	attr_accessor :symbol, :colour, :position

	def initialize colour,position
		@colour = colour
		@position = position			# The position is going to look like [5,6] which represents the 5 row and 6 column
		if @colour == :white
			@symbol = "\u2655"
		elsif @colour == :black
			@symbol = "\u265B"
		end

		@possible_moves = []
	end

	def possible_moves board,position=self.position
		hor = position[0].to_i
		ver = position[1].to_i
		@possible_moves = []

		right = ver + 1
		if right <= 8
			right_tile = board[hor][right]
			while right <= 8 && (right_tile == " " || (right_tile.respond_to?(:colour) && right_tile.colour != self.colour))
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
		if down <= 8
			down_tile = board[down][ver]
			while down <= 8 && (down_tile == " " || (down_tile.respond_to?(:colour) && down_tile.colour != self.colour))
				@possible_moves.push [down,ver]
				break if down_tile.respond_to?(:colour) && down_tile.colour != self.colour
				down += 1
				down_tile = board[down][ver] if down <= 8
			end
		end

		east = ver + 1
		north = hor - 1
		if east <= 8 && north > 0
			north_east = board[north][east]
			while east <= 8 && north > 0 && (north_east == " " || (north_east.respond_to?(:colour) && north_east.colour != self.colour))
				north_east = board[north][east]
				if north_east.respond_to?(:colour) && north_east.colour != self.colour
					@possible_moves.push [north,east]
					break
				end
				break if north_east.respond_to?(:colour) && north_east.colour == self.colour		
				@possible_moves.push [north,east]
				east += 1
				north -= 1
			end
		end
		west = ver - 1
		north = hor - 1
		if west > 0 && north > 0
			north_west = board[north][west]
			while west > 0 && north > 0 && (north_west == " " || (north_west.respond_to?(:colour) && north_west.colour != self.colour))
				north_west = board[north][west]
				if north_west.respond_to?(:colour) && north_west.colour != self.colour
					@possible_moves.push [north,west]
					break
				end
				break if north_west.respond_to?(:colour) && north_west.colour == self.colour
				@possible_moves.push [north,west]
				west -= 1
				north -= 1
			end
		end
		south = hor + 1
		east = ver + 1
		if south <= 8 && east <= 8
			south_east = board[south][east]
			while south <= 8 && east <= 8 && (south_east == " " || (south_east.respond_to?(:colour) && south_east.colour != self.colour))
				south_east = board[south][east]
			  if south_east.respond_to?(:colour) && south_east.colour != self.colour
			  	@possible_moves.push [south,east]
			  	break
			  end
			  break if south_east.respond_to?(:colour) && south_east.colour == self.colour
			  @possible_moves.push [south,east]
				south += 1
				east += 1
			end
		end
		south = hor + 1
		west = ver - 1
		if south <= 8 && west > 0
			south_west = board[south][west]
			while south <= 8 && west > 0 && (south_west == " " || (south_west.respond_to?(:colour) && south_west.colour != self.colour))
				south_west = board[south][west]
				if south_west.respond_to?(:colour) && south_west.colour != self.colour
					@possible_moves.push [south,west]
					break
				end
				break if south_west.respond_to?(:colour) && south_west.colour == self.colour
				@possible_moves.push [south,west]
				south += 1
				west -= 1
			end
		end
		@possible_moves
	end
end
