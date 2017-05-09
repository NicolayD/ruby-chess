
class King
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

		@possible_moves.push [hor+1,ver] if hor < 7 && (board[hor+1][ver] == " " || (board[hor+1][ver].respond_to?(:colour) && board[hor+1][ver].colour != self.colour))
		@possible_moves.push [hor,ver+1] if ver < 7 && (board[hor][ver+1] == " " || (board[hor][ver+1].respond_to?(:colour) && board[hor][ver+1].colour != self.colour))
		@possible_moves.push [hor+1,ver+1] if hor < 7 && ver < 7 && (board[hor+1][ver+1] == " " || (board[hor][ver+1].respond_to?(:colour) && board[hor][ver+1].colour != self.colour))
		@possible_moves.push [hor-1,ver] if hor > 1 && (board[hor-1][ver] == " " || (board[hor-1][ver].respond_to?(:colour) && board[hor-1][ver].colour != self.colour))
		@possible_moves.push [hor,ver-1] if ver > 1 && (board[hor][ver-1] == " " || (board[hor][ver-1].respond_to?(:colour) && board[hor][ver-1].colour != self.colour))
		@possible_moves.push [hor-1,ver-1] if hor > 1 && ver > 1 && (board[hor-1][ver-1] == " " || (board[hor-1][ver-1].respond_to?(:colour) && board[hor-1][ver-1].colour != self.colour))
		@possible_moves.push [hor-1,ver+1] if hor > 1 && ver < 7 && (board[hor-1][ver+1] == " " || (board[hor-1][ver+1].respond_to?(:colour) && board[hor-1][ver+1].colour != self.colour))
		@possible_moves.push [hor+1,ver-1] if hor < 7 && ver > 1 && (board[hor+1][ver-1] == " " || (board[hor+1][ver-1].respond_to?(:colour) && board[hor+1][ver-1].colour != self.colour))
		@possible_moves
	end
end