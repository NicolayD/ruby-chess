# Module used in the possible moves check of every piece
# Used to check if a specific tile is not an ally (empty or enemy),
# is an ally, or is an enemy.
module Moves
	def not_ally? board,x,y
		board[x][y].respond_to?(:colour) && board[x][y].colour == self.colour ? false : true
	end

	def enemy? board,x,y
		board[x][y].respond_to?(:colour) && board[x][y].colour != self.colour ? true : false
	end

	def ally? board,x,y
		board[x][y].respond_to?(:colour) && board[x][y].colour == self.colour ? true : false
	end
end