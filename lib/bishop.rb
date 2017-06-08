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

		east = ver + 1
		north = hor - 1
		if east <= 8 && north > 0
			while east <= 8 && north > 0 && not_ally?(board, north, east)
				if enemy?(board, north, east)
					@possible_moves.push [north, east]
					break
				end
				break if ally?(board, north, east)
				@possible_moves.push [north, east]
				east += 1
				north -= 1
			end
		end
		west = ver - 1
		north = hor - 1
		if west > 0 && north > 0
			while west > 0 && north > 0 && not_ally?(board, north, west)
				if enemy?(board, north, west)
					@possible_moves.push [north, west]
					break
				end
				break if ally?(board, north, west)
				@possible_moves.push [north, west]
				west -= 1
				north -= 1
			end
		end
		south = hor + 1
		east = ver + 1
		if south <= 8 && east <= 8
			while south <= 8 && east <= 8 && not_ally?(board, south, east)
				if enemy?(board, south, east)
					@possible_moves.push [south, east]
					break
				end
				break if ally?(board,south,east)
				@possible_moves.push [south,east]
				south += 1
				east += 1
			end
		end
		south = hor + 1
		west = ver - 1
		if south <= 8 && west > 0
			while south <= 8 && west > 0 && not_ally?(board, south, west)
				if enemy?(board, south, west)
					@possible_moves.push [south, west]
					break
				end
				break if ally?(board, south, west)
				@possible_moves.push [south, west]
				south += 1
				west -= 1
			end
		end
		@possible_moves
	end
end
