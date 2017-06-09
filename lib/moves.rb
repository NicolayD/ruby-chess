# Module used in the possible moves check of every piece
# Used to check if a specific tile is not an ally (empty or enemy),
# is an ally, or is an enemy.
# Additionaly used to check the horizontal, vertical,
# and diagonal moves of the rook, bishop and queen.
module Moves
	def not_ally?(board, x, y)
		board[x][y].respond_to?(:colour) && board[x][y].colour == self.colour ? false : true
	end

	def enemy?(board, x, y)
		board[x][y].respond_to?(:colour) && board[x][y].colour != self.colour ? true : false
	end

	def ally?(board, x, y)
		board[x][y].respond_to?(:colour) && board[x][y].colour == self.colour ? true : false
	end

  def move_up(board, moves_array, hor, ver)
    up = hor - 1
    if up > 0
      while up > 0 && not_ally?(board, up, ver)
        moves_array.push [up, ver]
        break if enemy?(board, up, ver)
        up -= 1
      end
    end
  end

  def move_down(board, moves_array, hor, ver)
    down = hor + 1
    if down <= 8
      while down <= 8 && not_ally?(board, down, ver)
        moves_array.push [down, ver]
        break if enemy?(board, down, ver)
        down += 1
      end
    end
  end

  def move_left(board, moves_array, hor, ver)
    left = ver - 1
    if left > 0
      while left > 0 && not_ally?(board, hor, left)
        moves_array.push [hor, left]
        break if enemy?(board, hor, left)
        left -= 1
      end
    end
  end

  def move_right(board, moves_array, hor, ver)
    right = ver + 1
    if right < 8
      while right <= 8 && not_ally?(board, hor, right)
        moves_array.push [hor, right]
        break if enemy?(board, hor, right)
        right += 1
      end
    end
  end

  def move_north_east(board, moves_array, hor, ver)
    east = ver + 1
    north = hor - 1
    if east <= 8 && north > 0
      while east <= 8 && north > 0 && not_ally?(board, north, east)
        if enemy?(board, north, east)
          moves_array.push [north, east]
          break
        end
        break if ally?(board, north, east)
        moves_array.push [north, east]
        east += 1
        north -= 1
      end
    end
  end

  def move_north_west(board, moves_array, hor, ver)
    west = ver - 1
    north = hor - 1
    if west > 0 && north > 0
      while west > 0 && north > 0 && not_ally?(board, north, west)
        if enemy?(board, north, west)
          moves_array.push [north, west]
          break
        end
        break if ally?(board, north, west)
        moves_array.push [north, west]
        west -= 1
        north -= 1
      end
    end
  end

  def move_south_east(board, moves_array, hor, ver)
    south = hor + 1
    east = ver + 1
    if south <= 8 && east <= 8
      while south <= 8 && east <= 8 && not_ally?(board, south, east)
        if enemy?(board, south, east)
          moves_array.push [south, east]
          break
        end
        break if ally?(board, south, east)
        moves_array.push [south, east]
        south += 1
        east += 1
      end
    end
  end

  def move_south_west(board, moves_array, hor, ver)
    south = hor + 1
    west = ver - 1
    if south <= 8 && west > 0
      while south <= 8 && west > 0 && not_ally?(board, south, west)
        if enemy?(board, south, west)
          moves_array.push [south, west]
          break
        end
        break if ally?(board, south, west)
        moves_array.push [south, west]
        south += 1
        west -= 1
      end
    end
  end
end
