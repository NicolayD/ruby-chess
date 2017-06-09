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

	def possible_moves(board, position=self.position)
		hor = position[0].to_i
		ver = position[1].to_i
		@possible_moves = []
    
    move_right(board, @possible_moves, hor, ver)

    move_left(board, @possible_moves, hor, ver)

    move_up(board, @possible_moves, hor, ver)
    
    move_down(board, @possible_moves, hor, ver)
=begin
		right = ver + 1
		if right < 8
			while right <= 8 && not_ally?(board, hor, right)
				@possible_moves.push [hor, right]
				break if enemy?(board, hor, right)
				right += 1
			end
		end
		left = ver - 1
		if left > 0
			while left > 0 && not_ally?(board, hor, left)
				@possible_moves.push [hor, left]
				break if enemy?(board, hor, left)
				left -= 1
			end
		end
		up = hor - 1
		if up > 0
			while up > 0 && not_ally?(board, up, ver)
				@possible_moves.push [up, ver]
				break if enemy?(board, up, ver)
				up -= 1
			end
		end
		down = hor + 1
		if down <= 8
			while down <= 8 && not_ally?(board, down, ver)
				@possible_moves.push [down, ver]
				break if enemy?(board, down, ver)
				down += 1
			end
		end
=end
		@possible_moves
	end
end
