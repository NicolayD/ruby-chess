require_relative 'moves'

class Bishop
	attr_accessor :symbol, :colour, :position
	include Moves

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
		if east <= 8 && north > 0
#			north_east = board[north][east]
			while east <= 8 && north > 0 && not_ally?(board,north,east) #(north_east == " " || (north_east.respond_to?(:colour) && north_east.colour != self.colour))
#				north_east = board[north][east]
				if enemy?(board,north,east) #north_east.respond_to?(:colour) && north_east.colour != self.colour
					@possible_moves.push [north,east]
					break
				end
				break if ally?(board,north,east) # north_east.respond_to?(:colour) && north_east.colour == self.colour
				@possible_moves.push [north,east]
				east += 1
				north -= 1
			end
		end
		west = ver - 1
		north = hor - 1
		if west > 0 && north > 0
#			north_west = board[north][west]
			while west > 0 && north > 0 && not_ally?(board,north,west) # (north_west == " " || (north_west.respond_to?(:colour) && north_west.colour != self.colour))
#				north_west = board[north][west]
				if enemy?(board,north,west) # north_west.respond_to?(:colour) && north_west.colour != self.colour
					@possible_moves.push [north,west]
					break
				end
				break if ally?(board,north,west) # north_west.respond_to?(:colour) && north_west.colour == self.colour
				@possible_moves.push [north,west]
				west -= 1
				north -= 1
			end
		end
		south = hor + 1
		east = ver + 1
		if south <= 8 && east <= 8
#			south_east = board[south][east]
			while south <= 8 && east <= 8 && not_ally?(board,south,east) # (south_east == " " || (south_east.respond_to?(:colour) && south_east.colour != self.colour))
#				south_east = board[south][east]
				if enemy?(board,south,east) # south_east.respond_to?(:colour) && south_east.colour != self.colour
					@possible_moves.push [south,east]
					break
				end
				break if ally?(board,south,east) # south_east.respond_to?(:colour) && south_east.colour == self.colour
				@possible_moves.push [south,east]
				south += 1
				east += 1
			end
		end
		south = hor + 1
		west = ver - 1
		if south <= 8 && west > 0
#			south_west = board[south][west]
			while south <= 8 && west > 0 && not_ally?(board,south,west) # (south_west == " " || (south_west.respond_to?(:colour) && south_west.colour != self.colour))
#				south_west = board[south][west]
				if enemy?(board,south,west) # south_west.respond_to?(:colour) && south_west.colour != self.colour
					@possible_moves.push [south,west]
					break
				end
				break if ally?(board,south,west) # south_west.respond_to?(:colour) && south_west.colour == self.colour
				@possible_moves.push [south,west]
				south += 1
				west -= 1
			end
		end
		@possible_moves
	end
end