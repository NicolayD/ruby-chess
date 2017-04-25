
class Bishop
	attr_accessor :symbol, :colour, :position

	def initialize colour,position
		@colour = colour
		@position = position			# The position is going to look like [5,6] which represents the 5 row and 6 column
		if @colour == :white
			@symbol = "\u2657"
		elsif @colour == :black
			@symbol = "\u265D"
		end

		@possible_moves = []
	end

	def possible_moves board,position=self.position
		hor = position[0].to_i
		ver = position[1].to_i
		@possible_moves = []

		east = ver + 1
		north = hor - 1
		if east < 8 && north > 0
			north_east = board[north][east]
			while east < 8 && north > 0 && (north_east == " " || (north_east.respond_to?(:colour) && north_east.colour != self.colour))
				@possible_moves.push [north,east]
				break if north_east.respond_to?(:colour) && north_east.colour != self.colour
				east += 1
				north -= 1
				north_east = board[north][east]
			end
		end
		west = ver - 1
		north = hor - 1
		if west > 0 && north > 0
			north_west = board[north][west]
			while west > 0 && north > 0 && (north_west == " " || (north_west.respond_to?(:colour) && north_west.colour != self.colour))
				@possible_moves.push [north,west]
				break if north_west.respond_to?(:colour) && north_west.colour != self.colour
				west -= 1
				north -= 1
				north_west = board[north][west]
			end
		end
		south = hor + 1
		east = ver + 1
		if south < 8 && east < 8
			south_east = board[south][east]
			while south < 8 && east < 8 && (south_east == " " || (south_east.respond_to?(:colour) && south_east.colour != self.colour))
				@possible_moves.push [south,east]
				break if south_east.respond_to?(:colour) && south_east.colour != self.colour
				south += 1
				east += 1
				south_east = board[south][east]
			end
		end
		south = hor + 1
		west = ver - 1
		if south < 8 && west > 0
			south_west = board[south][west]
			while south < 8 && west > 0 && (south_west == " " || (south_west.respond_to?(:colour) && south_west.colour != self.colour))
				@possible_moves.push [south,west]
				break if south_west.respond_to?(:colour) && south_west.colour != self.colour
				south += 1
				west -= 1
				south_west = board[south][west]
			end
		end

		@possible_moves
	end
end