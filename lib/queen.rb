require_relative 'moves'

class Queen
  include Moves
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

		east = ver + 1
    north = hor - 1
    if east <= 8 && north > 0
      while east <= 8 && north > 0 && not_ally?(board,north,east)
        if enemy?(board,north,east)
          @possible_moves.push [north,east]
          break
        end
        break if ally?(board,north,east)
        @possible_moves.push [north,east]
        east += 1
        north -= 1
      end
    end
		west = ver - 1
    north = hor - 1
    if west > 0 && north > 0
      while west > 0 && north > 0 && not_ally?(board,north,west)
        if enemy?(board,north,west)
          @possible_moves.push [north,west]
          break
        end
        break if ally?(board,north,west)
        @possible_moves.push [north,west]
        west -= 1
        north -= 1
      end
    end
		south = hor + 1
    east = ver + 1
    if south <= 8 && east <= 8
      while south <= 8 && east <= 8 && not_ally?(board,south,east)
        if enemy?(board,south,east)
          @possible_moves.push [south,east]
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
      while south <= 8 && west > 0 && not_ally?(board,south,west)
        if enemy?(board,south,west)
          @possible_moves.push [south,west]
          break
        end
        break if ally?(board,south,west)
        @possible_moves.push [south,west]
        south += 1
        west -= 1
      end
    end
		@possible_moves
	end
end
