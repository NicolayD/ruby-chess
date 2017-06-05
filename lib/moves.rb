module Moves
	# not_ally? method covers both free tiles and enemy tiles
	# while enemy? covers only enemy tiles, 
	# which is used only for the pawn possible moves check

	def not_ally? board,x,y
		!(board[x][y].respond_to?(:colour) && board[x][y].colour == self.colour) ? true : false
	end

	def enemy? board,x,y
		board[x][y].respond_to?(:colour) && board[x][y].colour != self.colour ? true : false
	end
end