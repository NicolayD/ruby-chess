STDOUT.sync = true				# For display in Git Bash

require_relative 'pawn'
require_relative 'bishop'
require_relative 'king'
require_relative 'queen'
require_relative 'knight'
require_relative 'rook'

class Game
	attr_accessor :board

	def initialize
		@board = [[" ","A","B","C","D","E","F","G","H"],
		["8",  Rook.new(:black,[1,1]),Knight.new(:black,[1,2]),Bishop.new(:black,[1,3]),Queen.new(:black,[1,4]),King.new(:black,[1,5]),Bishop.new(:black,[1,6]),Knight.new(:black,[1,7]),Rook.new(:black,[1,8])],
		["7",  Pawn.new(:black,[2,1]),Pawn.new(:black,[2,2]),Pawn.new(:black,[2,3]),Pawn.new(:black,[2,4]),Pawn.new(:black,[2,5]),Pawn.new(:black,[2,6]),Pawn.new(:black,[2,7]),Pawn.new(:black,[2,8])],
		["6",  " "," "," "," "," "," "," "," "],
		["5",  " "," "," "," "," "," "," "," "],
		["4",  " "," "," "," "," "," "," "," "],
		["3",  " "," "," "," "," "," "," "," "],
		["2",  Pawn.new(:white,[7,1]),Pawn.new(:white,[7,2]),Pawn.new(:white,[7,3]),Pawn.new(:white,[7,4]),Pawn.new(:white,[7,5]),Pawn.new(:white,[7,6]),Pawn.new(:white,[7,7]),Pawn.new(:white,[7,8])],
		["1",  Rook.new(:white,[8,1]),Knight.new(:white,[8,2]),Bishop.new(:white,[8,3]),Queen.new(:white,[8,4]),King.new(:white,[8,5]),Bishop.new(:white,[8,6]),Knight.new(:white,[8,7]),Rook.new(:white,[8,8])]]

	end

	def show_board
		@board.map do |line| 
			puts line.map { |square| square =~ /\w|\s/ ? square.rjust(3) : square.symbol.rjust(3) }.join(" ")
			puts
		end
	end

end

=begin
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
=end