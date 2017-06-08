# Module used in the possible moves check of every piece
# Used to check if a specific tile is not an ally (empty or enemy),
# is an ally, or is an enemy.
# Additionaly used to check the horizontal, vertical,
# and diagonal moves of the rook, bishop and queen.
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

  def move_up board,hor,ver
  end

  def move_down board,hor,ver
  end

  def move_left board,hor,ver
  end

  def move_right board,hor,ver
  end

  def move_north_east board,hor,ver
  end

  def move_north_west board,hor,ver
  end

  def move_south_east board,hor,ver
  end

  def move_south_west board,hor,ver
  end
end
