
class Knight
	attr_accessor :symbol, :colour, :position, :possible_moves

	def initialize colour,position
		@colour = colour
		@position = position			# The position is going to look like [5,6] which represents the 5 row and 6 column
		if @colour == :white
			@symbol = "\u2658"
		elsif @colour == :black
			@symbol = "\u265E"
		end

		@possible_moves = []
	end

	def possible_moves board,position=self.position
		@possible_moves = []
		@possible_moves.push [hor-2,ver-1] if board[hor-2][ver-1] == " " || (board[hor-2,ver-1].respond_to?(:colour) && board[hor-2,ver-1].colour != self.colour)
		@possible_moves.push [hor-2,ver+1] if board[hor-2][ver+1] == " " || (board[hor-2][ver+1].respond_to?(:colour) && board[hor-2][ver+1].colour != self.colour)
		@possible_moves.push [hor+2,ver-1] if board[hor+2][ver-1] == " " || (board[hor+2][ver-1].respond_to?(:colour) && board[hor+2][ver-1].colour != self.colour)
		@possible_moves.push [hor+2,ver+1] if board[hor+2][ver+1] == " " || (board[hor+2][ver+1].respond_to?(:colour) && board[hor+2][ver+1].colour != self.colour)
		@possible_moves.push [hor-1,ver+2] if board[hor-1][ver+2] == " " || (board[hor-1][ver+2].respond_to?(:colour) && board[hor-1][ver+2].colour != self.colour)
		@possible_moves.push [hor+1,ver+2] if board[hor+1][ver-2] == " " || (board[hor+1][ver-2].respond_to?(:colour) && board[hor+1][ver-2].colour != self.colour)
		@possible_moves.push [hor-1,ver-2] if board[hor-1][ver-2] == " " || (board[hor-1][ver-2].respond_to?(:colour) && board[hor-1][ver-2].colour != self.colour)
		@possible_moves.push [hor+1,ver-2] if board[hor+1][ver-2] == " " || (board[hor+1][ver-2].respond_to?(:colour) && board[hor+1][ver-2].colour != self.colour)
		@possible_moves
	end
end