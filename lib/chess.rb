require 'yaml'
require_relative 'pawn'
require_relative 'bishop'
require_relative 'king'
require_relative 'queen'
require_relative 'knight'
require_relative 'rook'
require_relative 'save_game'

# STDOUT.sync = true	# Uncomment if you use Git Bash on Windows

class Chess
	include SaveGame
	attr_accessor :board, :current_player, :chosen_piece, :move_from, :move_to
	attr_accessor :white_checked, :black_checked, :checkmate
	attr_accessor :all_white_moves, :all_black_moves, :no_capture_or_pawn_move
	attr_accessor :draw_message, :tiles_reached

	def initialize
		@board = [
							[' ', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'],
							['8',  Rook.new(:black, [1,1]), Knight.new(:black, [1,2]), 
							Bishop.new(:black, [1,3]),	Queen.new(:black, [1,4]), King.new(:black, [1,5]),
							Bishop.new(:black, [1,6]),	Knight.new(:black, [1,7]), Rook.new(:black, [1,8])],
							['7',  Pawn.new(:black, [2,1]), Pawn.new(:black, [2,2]),
							Pawn.new(:black, [2,3]),	Pawn.new(:black, [2,4]), Pawn.new(:black, [2,5]),
							Pawn.new(:black, [2,6]),	Pawn.new(:black, [2,7]), Pawn.new(:black, [2,8])],
							['6',  ' ',' ',' ',' ',' ',' ',' ',' '],
							['5',  ' ',' ',' ',' ',' ',' ',' ',' '],
							['4',  ' ',' ',' ',' ',' ',' ',' ',' '],
							['3',  ' ',' ',' ',' ',' ',' ',' ',' '],
							['2',  Pawn.new(:white, [7,1]), Pawn.new(:white, [7,2]),
							Pawn.new(:white, [7,3]), Pawn.new(:white, [7,4]), Pawn.new(:white, [7,5]),
							Pawn.new(:white, [7,6]), Pawn.new(:white, [7,7]), Pawn.new(:white, [7,8])],
							['1',  Rook.new(:white, [8,1]), Knight.new(:white, [8,2]),
							Bishop.new(:white, [8,3]), Queen.new(:white, [8,4]), King.new(:white, [8,5]),
							Bishop.new(:white, [8,6]), Knight.new(:white, [8,7]), Rook.new(:white, [8,8])]
		]

		@current_player = :white
		@move_to = []
		@move_from = []
		@white_checked = false
		@black_checked = false
		@checkmate = false
		@all_white_moves = []
		@all_black_moves = []
		@no_capture_or_pawn_move = 0
		@tiles_reached = {}
	end

	def show_board
		@board.map do |line| 
			puts line.map { |square| square =~ /\w|\s/ ? square.rjust(3) : square.symbol.rjust(3) }.join(" ")
			puts
		end
	end

	def swap_players
		@current_player == :white ? @current_player = :black : @current_player = :white
	end

	def convert_coordinates input
		coordinates = []
		case input[0].capitalize # Accept a string as an argument. First char is a letter, second char is a number.
		when 'A' then coordinates << 1	# Vertical
		when 'B' then coordinates << 2
		when 'C' then coordinates << 3
		when 'D' then coordinates << 4
		when 'E' then coordinates << 5
		when 'F' then coordinates << 6
		when 'G' then coordinates << 7
		when 'H' then coordinates << 8
		end
		case input[1].to_i
		when 1 then coordinates << 8	# Horizontal
		when 2 then coordinates << 7
		when 3 then coordinates << 6
		when 4 then coordinates << 5
		when 5 then coordinates << 4
		when 6 then coordinates << 3
		when 7 then coordinates << 2
		when 8 then coordinates << 1
		end
		coordinates.reverse!
	end

	def choose_piece
		puts "#{@current_player.capitalize}. Which piece do you want to move?"
		from = gets.chomp
		until from.size == 2 && ('A'..'H').include?(from[0].capitalize) && (1..8).include?(from[1].to_i)
			puts 'Please choose proper coordinates.'
			from = gets.chomp
		end

		@move_from = convert_coordinates from
		@chosen_piece = @board[@move_from[0]][@move_from[1]]

		until @chosen_piece != " " && @chosen_piece.respond_to?(:colour) && @chosen_piece.colour == @current_player
			puts 'You must choose your own piece.'
			from = gets.chomp
			until from.size == 2 && ('A'..'H').include?(from[0].capitalize) && (1..8).include?(from[1].to_i)
				puts 'Please choose proper coordinates.'
				from = gets.chomp
			end
			@move_from = convert_coordinates from
			@chosen_piece = @board[@move_from[0]][@move_from[1]]
		end

		puts 'Where do you want to move it?'
		to = gets.chomp
		until to.size == 2 && ('A'..'H').include?(to[0].capitalize) && (0..8).include?(to[1].to_i)
			puts 'Please choose proper coordinates.'
			puts 'Where do you want to move it?'
			to = gets.chomp
		end
		@move_to = convert_coordinates to
	end

	def move from=@move_from,to=@move_to

		moves = @chosen_piece.possible_moves(@board)

		if moves.include?(to) && !@board[to[0]][to[1]].is_a?(King)
			chosen_position = @board[to[0]][to[1]]
			@board[to[0]][to[1]] = @chosen_piece
			@board[from[0]][from[1]] = " "
			@board[to[0]][to[1]].position = to

			calculate_moves
			check?
			while (@white_checked && @current_player == :white) || (@black_checked && @current_player == :black)
				puts 'Your king is checked. Choose a proper move.'
				@board[from[0]][from[1]] = @chosen_piece
				@board[to[0]][to[1]] = chosen_position
				@board[from[0]][from[1]].position = from
				choose_piece
				move
				calculate_moves
				check?
			end

			if chosen_position != " " || @chosen_piece.is_a?(Pawn)
				@no_capture_or_pawn_move = 0
			else
				@no_capture_or_pawn_move += 1
			end

			# For the draw check.
			# Record every time a piece (except a pawn) reaches a specific tile repeatedly.
			# Use a hash with tiles as keys.
			# Every tile itself is a hash with object ids for the pieces as keys.
			# And numbers of time they reached that tile as values.

			if !@chosen_piece.is_a?(Pawn)
				if @tiles_reached.has_key?(to)
					if @tiles_reached[to].has_key?(@chosen_piece.object_id)
						@tiles_reached[to][@chosen_piece.object_id] += 1
					else
						@tiles_reached[to][@chosen_piece.object_id] = 1
					end
				else 
					@tiles_reached[to] = {}
					@tiles_reached[to][@chosen_piece.object_id] = 1
				end
			end
		else
			puts 'You cannot move there.'
			puts 'Choose another move.'
			choose_piece
			move
		end

		calculate_moves
		checkmate?

		if @chosen_piece.is_a?(Pawn)
			@chosen_piece.promote(@board)
		end
	end

	def calculate_moves
		@all_white_moves = []
		@all_black_moves = []

		@board.each do |row|
			row.each do |piece|
				if piece.respond_to?(:colour)
					moves = piece.possible_moves(@board)
					moves.each do |move| 
						piece.colour == :white ? @all_white_moves << move : @all_black_moves << move
					end
				end
			end
		end
	end

	def draw?	# Add separate messages for the different draws.
		if @no_capture_or_pawn_move == 75	# Automatic draw at 75 moves without a capture or a pawn move
			@draw_message = 'No piece captured or pawn moved for 75 moves.'
			return true
		end
		calculate_moves
		if !@white_checked && @all_white_moves.empty?
			@draw_message = 'Stalemate.'
			return true
		end
		if !@black_checked && @all_black_moves.empty?
			@draw_message = 'Stalemate.'
			return true 
		end
		
		# Threefold repetition is not automatic.
		# That's why fivefold repetition is used.

		@tiles_reached.each do |tile,pieces|
			if pieces.has_value? 5
				@draw_message = 'Fivefold repetition of the same move.'
				return true
			end
		end
		false
	end

	def check?
		@white_checked = false
		@black_checked = false

		@board.each do |row|
			row.each do |piece|
				moves = piece.possible_moves(@board) if piece.respond_to?(:colour)
				if !moves.nil?
					moves.each do |pos_move|
						x = pos_move[0]
						y = pos_move[1]
						if @board[x][y].is_a?(King) && @board[x][y].colour == :white
							@white_checked = true
						elsif @board[x][y].is_a?(King) && @board[x][y].colour == :black
							@black_checked = true
						end
					end
				end
			end
		end

		if @white_checked || @black_checked
			return true
		else
			return false
		end
	end

	def checkmate?
		# Because the check is at the end of the turn, after the move of the enemy.
		if @white_checked && @current_player == :black
			@checkmate = true
			catch(:no_checkmate) do
			@board.each_with_index do |row,hor|																	
				row.each_with_index do |piece,ver|
					if piece.respond_to?(:colour) && piece.colour == :white
						moves = piece.possible_moves(@board)
						moves.each do |pos_move|
							x = pos_move[0]
							y = pos_move[1]
							# Skip when a possible move is an enemy King.
							# It's in the possible moves because of the check check,
							# but we shouldn't count him as a real possible move.
							next if @board[x][y].is_a?(King)
							checked_place = @board[x][y]
							@board[x][y] = @board[hor][ver]
							@board[hor][ver] = ' '
							check?
							@board[hor][ver] = @board[x][y]
							@board[x][y] = checked_place
							if !@white_checked
								@checkmate = false
								throw :no_checkmate
							end
						end
					end
				end
			end
			end
		# The check is at the end of the turn.	
		elsif @black_checked && @current_player == :white
			@checkmate = true
			catch(:no_checkmate) do
			@board.each_with_index do |row,hor|
				row.each_with_index do |piece,ver|
					if piece.respond_to?(:colour) && piece.colour == :black
						moves = piece.possible_moves(@board)
						moves.each do |pos_move|
							x = pos_move[0]
							y = pos_move[1]
							# Skip when a possible move is an enemy King.
							next if @board[x][y].is_a?(King)
							checked_place = @board[x][y]
							@board[x][y] = @board[hor][ver]
							@board[hor][ver] = ' '
							check?
							@board[hor][ver] = @board[x][y]
							@board[x][y] = checked_place
							if !@black_checked
								@checkmate = false
								throw :no_checkmate
							end
						end
					end
				end
			end
			end
		end
		@checkmate
	end
end
