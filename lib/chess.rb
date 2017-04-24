STDOUT.sync = true				# For use in Git Bash
class Game

	attr_accessor :board, :current_player, :current_piece, :current_piece_index, :white_check, :black_check, :checkmate, :draw
	attr_reader :white, :black

	# The current piece is the one that was chosen to move

	def initialize
		@white = { rook: "\u2656", knight: "\u2658", bishop: "\u2657", pawn: "\u2659", king: "\u2654", queen: "\u2655" }
		@black = { rook: "\u265C", knight: "\u265E", bishop: "\u265D", pawn: "\u265F", king: "\u265A", queen: "\u265B" }

		@board = [["","A","B","C","D","E","F","G","H"],
							[8,  @black[:rook],@black[:knight],@black[:bishop],@black[:queen],@black[:king],@black[:bishop],@black[:knight],@black[:rook]],
							[7,  @black[:pawn],@black[:pawn],@black[:pawn],@black[:pawn],@black[:pawn],@black[:pawn],@black[:pawn],@black[:pawn]],
							[6,  " "," "," "," "," "," "," "," "],
							[5,  " "," "," "," "," "," "," "," "],
							[4,  " "," "," "," "," "," "," "," "],
							[3,  " "," "," "," "," "," "," "," "],
							[2,  @white[:pawn],@white[:pawn],@white[:pawn],@white[:pawn],@white[:pawn],@white[:pawn],@white[:pawn],@white[:pawn]],
						  [1,  @white[:rook],@white[:knight],@white[:bishop],@white[:queen],@white[:king],@white[:bishop],@white[:knight],@white[:rook]]]

		@current_player = :white
		@white_check = false
		@black_check = false

	end

	def show_board
		@board.map do |line| 
			puts line.map { |square| square.to_s.rjust(3) }.join(" ") 
			puts
		end
	end

	def swap_players
		@current_player == :white ? @current_player = :black : @current_player = :white
	end


	def choose_piece
		puts "#{@current_player.capitalize}. Which piece do you want to move?"			# Add current player check here
		answer = gets.chomp
		possible_choices = {}
		possible_choices[:num] = [1,2,3,4,5,6,7,8]
		possible_choices[:let] = ["A", "B", "C", "D", "E", "F", "G", "H"]
		until possible_choices[:num].include?(answer[0].to_i) && possible_choices[:let].include?(answer[1].capitalize)
			puts "Please choose proper coordinates."
			answer = gets.chomp
		end

		@current_piece_index = find_piece answer
		@current_piece = @board[current_piece_index[0]][@current_piece_index[1]]

		if @current_player == :white && !@white.has_value?(@current_piece)
			until @white.has_value?(@current_piece)
				puts 'You must choose your own colour.'
				choose_piece
			end
		end
	end


	def find_piece x
		ind = []
		case x[0].to_i			# Accept a string as an argument. First char is number, second char is a letter.
		when 1				# Horizontal
			ind << 8
		when 2
			ind << 7
		when 3
			ind << 6
		when 4
			ind << 5
		when 5
			ind << 4
		when 6
			ind << 3
		when 7
			ind << 2
		when 8
			ind << 1
		end
		case x[1].capitalize
		when "A"			# Vertical
			ind << 1
		when "B"
			ind << 2
		when "C"
			ind << 3
		when "D"
			ind << 4
		when "E"
			ind << 5
		when "F"
			ind << 6
		when "G"
			ind << 7
		when "H"
			ind << 8
		end

		ind
	end

	def possible_moves index=@current_piece_index
		hor = index[0].to_i
		ver = index[1].to_i

		moves = []

		piece = @board[hor][ver]

		case piece 										# Saves the array indices of every possible move
		when @white[:pawn]
			moves.push [hor-1,ver] if @board[hor-1][ver] != nil && !@white.has_value?(@board[hor-1][ver])
			moves.push [hor-1,ver-1] if @black.has_value? @board[hor-1][ver-1] 
			moves.push [hor-1,ver+1] if @black.has_value? @board[hor-1][ver+1] 

		when @black[:pawn]
			moves.push [hor+1,ver] if @board[hor+1,ver] != nil && !@black.has_value?(@board[hor+1][ver])
			moves.push [hor+1,ver-1] if @white.has_value? @board[hor+1][ver-1]
			moves.push [hor+1,ver+1] if @white.has_value? @board[hor+1][ver+1]

		when @white[:king]
			moves.push [hor+1,ver] if @board[hor+1][ver] == " " || @black.has_value?(@board[hor+1][ver])
			moves.push [hor,ver+1] if @board[hor][ver+1] != " " || @black.has_value?(@board[hor][ver+1])
			moves.push [hor+1,ver+1] if @board[hor+1][ver+1] == " " || @black.has_value?(@board[hor+1][ver+1])
			moves.push [hor-1,ver] if @board[hor-1][ver] == " " || @black.has_value?(@board[hor-1][ver])
			moves.push [hor,ver-1] if @board[hor][ver-1] == " " || @black.has_value?(@board[hor][ver-1])
			moves.push [hor-1,ver-1] if @board[hor-1][ver-1] == " " || @black.has_value?(@board[hor-1][ver-1])
			moves.push [hor-1,ver+1] if @board[hor-1][ver+1] == " " || @black.has_value?(@board[hor-1][ver+1])
			moves.push [hor+1,ver-1] if @board[hor+1][ver-1] == " " || @black.has_value?(@board[hor+1][ver-1])
			
			@board.each_with_index do |row,horiz|
				row.each_with_index do |cur_piece,vert|
					if @black.has_value? cur_piece
						black_moves = possible_moves(horiz.to_s + vert.to_s)
						if black_moves.include? @current_piece_index
							moves.delete([horiz,vert])
						end
					end
				end
			end


		when @black[:king]
			moves.push [hor+1,ver] if @board[hor+1][ver] == " " || @white.has_value?(@board[hor+1][ver])
			moves.push [hor,ver+1] if @board[hor][ver+1] == " " || @white.has_value?(@board[hor][ver+1])
			moves.push [hor+1,ver+1] if @board[hor+1][ver+1] == " " || @white.has_value?(@board[hor+1][ver+1])
			moves.push [hor-1,ver] if @board[hor-1][ver] == " " || @white.has_value?(@board[hor-1][ver])
			moves.push [hor,ver-1] if @board[hor][ver-1] == " " || @white.has_value?(@board[hor][ver-1])
			moves.push [hor-1,ver-1] if @board[hor-1][ver-1] == " " || @white.has_value?(@board[hor-1][ver-1])
			moves.push [hor-1,ver+1] if @board[hor-1][ver+1] == " " || @white.has_value?(@board[hor-1][ver+1])
			moves.push [hor+1,ver-1] if @board[hor+1][ver-1] == " " || @white.has_value?(@board[hor+1][ver-1])
			
			@board.each_with_index do |row,horiz|
				row.each_with_index do |cur_piece,vert|
					if @white.has_value? cur_piece
						white_moves = possible_moves(horiz.to_s + vert.to_s)
						if white_moves.include? @current_piece_index
							moves.delete([horiz,vert])
						end
					end
				end
			end

		when @white[:queen]				# Same as white rook + white bishop
			right = ver + 1
			if right < 8
				right_tile = @board[hor][right]
				while right < 8 && !@white.has_value?(right_tile) && right_tile != nil 
					moves.push [hor,right]
					break if @black.has_value? right_tile
					right += 1
					right_tile = @board[hor][right]
				end
			end
			left = ver - 1
			if left > 0
				left_tile = @board[hor][left]
				while left > 0 && !@white.has_value?(left_tile) && left_tile != nil
					moves.push [hor,left]
					break if @black.has_value? left_tile
					left -= 1
					left_tile = @board[hor][left]
				end
			end
			up = hor - 1
			if up > 0
				up_tile = @board[up][ver]
				while up > 0 && !@white.has_value?(up_tile) && up_tile != nil
					moves.push [up,ver]
					break if @black.has_value? up_tile
					up -= 1
					up_tile = @board[up][ver]
				end
			end
			down = hor + 1
			if down < 8
				down_tile = @board[down][ver]
				while down < 8 && !@white.has_value?(down_tile) && down_tile != nil
					moves.push [down,ver]
					break if @black.has_value? down_tile
					down += 1
					down_tile = @board[down][ver]
				end
			end

			east = ver + 1
			north = hor - 1
			if east < 8 && north > 0
				north_east = @board[north][east]
				while east < 8 && north > 0 && !@white.has_value?(north_east) && north_east != nil 
					moves.push [north,east]
					break if @black.has_value? north_east
					east += 1
					north -= 1
					north_east = @board[north][east]
				end
			end
			west = ver - 1
			north = hor - 1
			if west > 0 && north > 0
				north_west = @board[north][west]
				while west > 0 && north > 0 && !@white.has_value?(north_west) && north_west != nil
					moves.push [north,west]
					break if @black.has_value? north_west
					west -= 1
					north -= 1
					left_tile = @board[north][west]
				end
			end
			south = hor + 1
			east = ver + 1
			if south < 8 && east < 8
				south_east = @board[south][east]
				while south < 8 && east < 8 && !@white.has_value?(south_east) && south_east != nil
					moves.push [south,east]
					break if @black.has_value? south_east
					south += 1
					east += 1
					south_east = @board[south][east]
				end
			end
			south = hor + 1
			west = ver - 1
			if south < 8 && west > 0
				south_west = @board[south][west]
				while south < 8 && west > 0 && !@white.has_value?(south_west) && south_west != nil
					moves.push [south,west]
					break if @black.has_value? south_west
					south += 1
					west -= 1
					south_west = @board[south][west]
				end
			end

		when @black[:queen]				# Same as black rook + black bishop
			right = ver + 1
			if right < 8
				right_tile = @board[hor][right]
				while right < 8 && !@black.has_value?(right_tile) && right_tile != nil 
					moves.push [hor,right]
					break if @white.has_value? right_tile
					right += 1
					right_tile = @board[hor][right]
				end
			end
			left = ver - 1
			if left > 0
				left_tile = @board[hor][left]
				while left > 0 && !@black.has_value?(left_tile) && left_tile != nil
					moves.push [hor,left]
					break if @white.has_value? left_tile
					left -= 1
					left_tile = @board[hor][left]
				end
			end
			up = hor - 1
			if up > 0
				up_tile = @board[up][ver]
				while up > 0 && !@black.has_value?(up_tile) && up_tile != nil
					moves.push [up,ver]
					break if @white.has_value? up_tile
					up -= 1
					up_tile = @board[up][ver]
				end
			end
			down = hor + 1
			if down < 8
				down_tile = @board[down][ver]
				while down < 8 && !@black.has_value?(down_tile) && down_tile != nil
					moves.push [down,ver]
					break if @white.has_value? down_tile
					down += 1
					down_tile = @board[down][ver]
				end
			end

			east = ver + 1
			north = hor - 1
			if east < 8 && north > 0
				north_east = @board[north][east]
				while east < 8 && north > 0 && !@black.has_value?(north_east) && north_east != nil 
					moves.push [north,east]
					break if @white.has_value? north_east
					east += 1
					north -= 1
					north_east = @board[north][east]
				end
			end
			west = ver - 1
			north = hor - 1
			if west > 0 && north > 0
				north_west = @board[north][west]
				while west > 0 && north > 0 && !@black.has_value?(north_west) && north_west != nil
					moves.push [north,west]
					break if @white.has_value? north_west
					west -= 1
					north -= 1
					left_tile = @board[north][west]
				end
			end
			south = hor + 1
			east = ver + 1
			if south < 8 && east < 8
				south_east = @board[south][east]
				while south < 8 && east < 8 && !@black.has_value?(south_east) && south_east != nil
					moves.push [south,east]
					break if @white.has_value? south_east
					south += 1
					east += 1
					south_east = @board[south][east]
				end
			end
			south = hor + 1
			west = ver - 1
			if south < 8 && west > 0
				south_west = @board[south][west]
				while south < 8 && west > 0 && !@black.has_value?(south_west) && south_west != nil
					moves.push [south,west]
					break if @white.has_value? south_west
					south += 1
					west -= 1
					south_west = @board[south][west]
				end
			end

		when @white[:rook]
			right = ver + 1
			if right < 8
				right_tile = @board[hor][right]
				while right < 8 && !@white.has_value?(right_tile) && right_tile != nil 
					moves.push [hor,right]
					break if @black.has_value? right_tile
					right += 1
					right_tile = @board[hor][right]
				end
			end
			left = ver - 1
			if left > 0
				left_tile = @board[hor][left]
				while left > 0 && !@white.has_value?(left_tile) && left_tile != nil
					moves.push [hor,left]
					break if @black.has_value? left_tile
					left -= 1
					left_tile = @board[hor][left]
				end
			end
			up = hor - 1
			if up > 0
				up_tile = @board[up][ver]
				while up > 0 && !@white.has_value?(up_tile) && up_tile != nil
					moves.push [up,ver]
					break if @black.has_value? up_tile
					up -= 1
					up_tile = @board[up][ver]
				end
			end
			down = hor + 1
			if down < 8
				down_tile = @board[down][ver]
				while down < 8 && !@white.has_value?(down_tile) && down_tile != nil
					moves.push [down,ver]
					break if @black.has_value? down_tile
					down += 1
					down_tile = @board[down][ver]
				end
			end

		when @black[:rook]
			right = ver + 1
			if right < 8
				right_tile = @board[hor][right]
				while right < 8 && !@black.has_value?(right_tile) && right_tile != nil 
					moves.push [hor,right]
					break if @white.has_value? right_tile
					right += 1
					right_tile = @board[hor][right]
				end
			end
			left = ver - 1
			if left > 0
				left_tile = @board[hor][left]
				while left > 0 && !@black.has_value?(left_tile) && left_tile != nil
					moves.push [hor,left]
					break if @white.has_value? left_tile
					left -= 1
					left_tile = @board[hor][left]
				end
			end
			up = hor - 1
			if up > 0
				up_tile = @board[up][ver]
				while up > 0 && !@black.has_value?(up_tile) && up_tile != nil
					moves.push [up,ver]
					break if @white.has_value? up_tile
					up -= 1
					up_tile = @board[up][ver]
				end
			end
			down = hor + 1
			if down < 8
				down_tile = @board[down][ver]
				while down < 8 && !@black.has_value?(down_tile) && down_tile != nil
					moves.push [down,ver]
					break if @white.has_value? down_tile
					down += 1
					down_tile = @board[down][ver]
				end
			end

		when @white[:bishop]
			east = ver + 1
			north = hor - 1
			if east < 8 && north > 0
				north_east = @board[north][east]
				while east < 8 && north > 0 && !@white.has_value?(north_east) && north_east != nil 
					moves.push [north,east]
					break if @black.has_value? north_east
					east += 1
					north -= 1
					north_east = @board[north][east]
				end
			end
			west = ver - 1
			north = hor - 1
			if west > 0 && north > 0
				north_west = @board[north][west]
				while west > 0 && north > 0 && !@white.has_value?(north_west) && north_west != nil
					moves.push [north,west]
					break if @black.has_value? north_west
					west -= 1
					north -= 1
					left_tile = @board[north][west]
				end
			end
			south = hor + 1
			east = ver + 1
			if south < 8 && east < 8
				south_east = @board[south][east]
				while south < 8 && east < 8 && !@white.has_value?(south_east) && south_east != nil
					moves.push [south,east]
					break if @black.has_value? south_east
					south += 1
					east += 1
					south_east = @board[south][east]
				end
			end
			south = hor + 1
			west = ver - 1
			if south < 8 && west > 0
				south_west = @board[south][west]
				while south < 8 && west > 0 && !@white.has_value?(south_west) && south_west != nil
					moves.push [south,west]
					break if @black.has_value? south_west
					south += 1
					west -= 1
					south_west = @board[south][west]
				end
			end

		when @black[:bishop]
			east = ver + 1
			north = hor - 1
			if east < 8 && north > 0
				north_east = @board[north][east]
				while east < 8 && north > 0 && !@black.has_value?(north_east) && north_east != nil 
					moves.push [north,east]
					break if @white.has_value? north_east
					east += 1
					north -= 1
					north_east = @board[north][east]
				end
			end
			west = ver - 1
			north = hor - 1
			if west > 0 && north > 0
				north_west = @board[north][west]
				while west > 0 && north > 0 && !@black.has_value?(north_west) && north_west != nil
					moves.push [north,west]
					break if @white.has_value? north_west
					west -= 1
					north -= 1
					left_tile = @board[north][west]
				end
			end
			south = hor + 1
			east = ver + 1
			if south < 8 && east < 8
				south_east = @board[south][east]
				while south < 8 && east < 8 && !@black.has_value?(south_east) && south_east != nil
					moves.push [south,east]
					break if @white.has_value? south_east
					south += 1
					east += 1
					south_east = @board[south][east]
				end
			end
			south = hor + 1
			west = ver - 1
			if south < 8 && west > 0
				south_west = @board[south][west]
				while south < 8 && west > 0 && !@black.has_value?(south_west) && south_west != nil
					moves.push [south,west]
					break if @white.has_value? south_west
					south += 1
					west -= 1
					south_west = @board[south][west]
				end
			end

		when @white[:knight]
			moves.push [hor-2,ver-1] if @board[hor-2][ver-1] == " " || @black.has_value?(@board[hor-2][ver-1])
			moves.push [hor-2,ver+1] if @board[hor-2][ver+1] == " " || @black.has_value?(@board[hor-2][ver+1])
			moves.push [hor+2,ver-1] if @board[hor+2][ver-1] == " " || @black.has_value?(@board[hor+2][ver-1])
			moves.push [hor+2,ver+1] if @board[hor+2][ver+1] == " " || @black.has_value?(@board[hor+2][ver+1])
			moves.push [hor-1,ver+2] if @board[hor-1][ver+2] == " " || @black.has_value?(@board[hor-1][ver+2])
			moves.push [hor+1,ver+2] if @board[hor+1][ver-2] == " " || @black.has_value?(@board[hor+1][ver-2])
			moves.push [hor-1,ver-2] if @board[hor-1][ver-2] == " " || @black.has_value?(@board[hor-1][ver-2])
			moves.push [hor+1,ver-2] if @board[hor+1][ver-2] == " " || @black.has_value?(@board[hor+1][ver-2])

		when @black[:knight]
			moves.push [hor-2,ver-1] if @board[hor-2][ver-1] == " " || @white.has_value?(@board[hor-2][ver-1])
			moves.push [hor-2,ver+1] if @board[hor-2][ver+1] == " " || @white.has_value?(@board[hor-2][ver+1])
			moves.push [hor+2,ver-1] if @board[hor+2][ver-1] == " " || @white.has_value?(@board[hor+2][ver-1])
			moves.push [hor+2,ver+1] if @board[hor+2][ver+1] == " " || @white.has_value?(@board[hor+2][ver+1])
			moves.push [hor-1,ver+2] if @board[hor-1][ver+2] == " " || @white.has_value?(@board[hor-1][ver+2])
			moves.push [hor+1,ver+2] if @board[hor+1][ver-2] == " " || @white.has_value?(@board[hor+1][ver-2])
			moves.push [hor-1,ver-2] if @board[hor-1][ver-2] == " " || @white.has_value?(@board[hor-1][ver-2])
			moves.push [hor+1,ver-2] if @board[hor+1][ver-2] == " " || @white.has_value?(@board[hor+1][ver-2])
		end

		moves
	end

	def check? position
		king_position = []
		moves = possible_moves(position)
		moves.each do |move|
			if @board[move[0]][move[1]] == @white[:king] && @current_player == :black
				puts 'White king is in check.'
				king_position << move[0]
				king_position << move[1]
				if possible_moves(king_position) == nil
					@checkmate == true
					return 'Checkmate. Black wins.'
				else
				 return @white_check == true
				end
			elsif @board[move[0]][move[1]] == @black[:king] && @current_player == :white
				puts 'Black king is in check.'
				king_position << move[0]
				king_position << move[1]
				if possible_moves(king_position) == nil
					@checkmate == true
					return 'Checkmate. White wins.'
				else
					return @black_check == true
				end
			end
		end

		@white_check,@black_chek = false,false
	end

	def move start,finish
		start_pos = @current_piece_index
		end_pos = find_piece finish

		piece = @board[start_pos[0]][start_pos[1]]

		if @white_check
			until !@white_check
				puts 'You are in check. Choose again.'
				puts 'Move piece:'
				start = gets.chomp
				puts 'Move to:'
				finish = gets.chomp
				move start,finish
			end
		elsif @black_check
			until !@black_check
				puts 'You are in check. Choose again.'
				puts 'Move piece:'
				start = gets.chomp
				puts 'Move to:'
				finish = gets.chomp
				move start,finish
			end
		end

		if @current_player == :white && !@white.has_value?(piece)		# The current player check is not working properly
			puts 'You must move a white piece.'
			puts 'Please choose again.'
			start = gets.chomp
			finish = gets.chomp
			move start,finish
		end
		if @current_player == :black && !@black.has_value?(piece)
			puts 'You must move a black piece.'
			puts 'Please choose again.'
			puts 'Move tile:'
			start = gets.chomp
			puts 'Move to:'
			finish = gets.chomp
			move start,finish
		end

		moves = possible_moves(start_pos)
		if @current_player == :white
			if moves.include?(end_pos) && @board[end_pos[0]][end_pos[1]] != @black[:king]
				@board[start_pos[0]][start_pos[1]] = " "
				@board[end_pos[0]][end_pos[1]] = piece
			else
				puts 'You cannot take the king.'
				puts 'Choose another move.'
				puts 'Move tile:'
				start = gets.chomp
				puts 'Move to:'
				finish = gets.chomp
				move start,finish
			end
		end

		if @current_player == :black
			if moves.include?(end_pos) && @board[end_pos[0]][end_pos[1]] != @white[:king]
				@board[start_pos[0]][start_pos[1]] = " "
				@board[end_pos[0]][end_pos[1]] = piece
			else
				puts 'You cannot take the king.'
				puts 'Choose another move.'
				puts 'Move tile:'
				start = gets.chomp
				puts 'Move to:'
				finish = gets.chomp
				move start,finish
			end
		end

		check? end_pos

		if @white_check
			@current_player = :white
			until !@white_check
				puts 'You are in check. Choose again.'
				puts 'Move piece:'
				start = gets.chomp
				puts 'Move to:'
				finish = gets.chomp
				move start,finish
			end
		elsif @black_check
			@current_player = :black
			until !@black_check
				puts 'You are in check. Choose again.'
				puts 'Move piece:'
				start = gets.chomp
				puts 'Move to:'
				finish = gets.chomp
				move start,finish
			end
		end
		end?
	end

	def end?
		return true if @checkmate

		# Check for stalemate
		player_moves = []
		if @current_player == :white
			@board.each_with_index do |row,hor|
				row.each_with_index do |piece,ver|
					if @white.has_value? piece
						player_moves << possible_moves(hor.to_s + ver.to_s)
					end
				end
			end
		elsif @current_player == :black
			@board.each_with_index do |row,hor|
				row.each_with_index do |piece,ver|
					if @black.has_value? piece
						player_moves << possible_moves(hor.to_s + ver.to_s)
					end
				end
			end
		end

		return draw == true if player_moves == nil

		# Check for impossibility of checkmate

		pieces_on_board = []
		@board.each_with_index do |row,hor|
			row.each_with_index do |piece,ver|
				if @white.has_value?(piece) || @black.has_value?(piece)
					pieces_on_board << piece
				end
			end
		end

		if pieces_on_board.size == 2 # Two kings.
			return draw == true
		elsif pieces_on_board.size == 3 && (pieces_on_board.include?(@white[:bishop]) || pieces_on_board.include?(@black[:bishop]))
			return draw == true
		elsif pieces_on_board.size == 3 && (pieces_on_board.include?(@white[:knight]) || pieces_on_board.include?(@black[:knight]))
			return draw == true
		elsif pieces_on_board.size == 4 && pieces_on_board.include?(@white[:bishop]) && pieces_on_board.include?(@black[:bishop])
			@board.each_with_index do |row,hor|
				row.each_with_index do |piece,ver|
					if piece == @white[:bishop]
						white_bishop_pos = [hor,ver]
					elsif piece == @black[:bishop]
						black_bishop_pos = [hor,ver]
					end
				end
			end
			if (white_bishop_pos[0]+white_bishop_pos[1]).odd? && (black_bishop_pos[0]+black_bishop_pos[1]).odd?
				return draw == true		# Bishops on same colour
			elsif !(white_bishop_pos[0]+white_bishop_pos[1]).odd? && !(black_bishop_pos[0]+black_bishop_pos[1]).odd?
				return draw == true		# Bishops on same colour
			end
		end
	end
end
