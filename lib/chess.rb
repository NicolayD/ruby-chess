STDOUT.sync = true				# For display in Git Bash

require_relative 'pawn'
require_relative 'bishop'
require_relative 'king'
require_relative 'queen'
require_relative 'knight'
require_relative 'rook'

class Chess
	attr_accessor :board, :current_player, :chosen_piece, :move_to

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

		@current_player = :white
		@move_to = []
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
		case input[0].to_i			# Accept a string as an argument. First char is number, second char is a letter.
		when 1	then coordinates << 8			# Horizontal
		when 2 then coordinates << 7
		when 3 then coordinates << 6
		when 4 then coordinates << 5
		when 5 then coordinates << 4
		when 6 then coordinates << 3
		when 7 then coordinates << 2
		when 8 then coordinates << 1
		end
		case input[1].capitalize
		when "A" then coordinates << 1	# Vertical
		when "B" then coordinates << 2
		when "C" then coordinates << 3
		when "D" then coordinates << 4
		when "E" then coordinates << 5
		when "F" then coordinates << 6
		when "G" then coordinates << 7
		when "H" then coordinates << 8
		end

		coordinates
	end

	def choose_piece

		puts "#{@current_player.capitalize}. Which piece do you want to move?"
		from = gets.chomp
		until from.size == 2 && (1..8).include?(from[0].to_i) && ("A".."H").include?(from[1].capitalize)
			puts "Please choose proper coordinates."
			from = gets.chomp
		end

		start = convert_coordinates from
		@chosen_piece = @board[start[0]][start[1]]

		until @chosen_piece != " " && @chosen_piece.respond_to?(:colour) && @chosen_piece.colour == @current_player
			puts 'You must choose your own piece.'
			from = gets.chomp
			start = convert_coordinates from
			@chosen_piece = @board[start[0]][start[1]]
		end

		puts 'Where do you want to move it?'
		to = gets.chomp
		until (0..8).include?(to[0].to_i) && ("A".."H").include?(to[1].capitalize)
			puts 'Please choose proper coordinates.'
			to = gets.chomp
		end
		@move_to = convert_coordinates to
	end

	def move from=@chosen_piece.position,to=@move_to

		moves = @chosen_piece.possible_moves @board

		if moves.include?(to) && !@board[to[0]][to[1]].is_a?(King)
			@board[to[0]][to[1]] = @chosen_piece
			@board[from[0]][from[1]] = " "
			@board[to[0]][to[1]].position = to
		else
			puts 'You cannot move there.'
			puts 'Choose another move.'
			choose_piece
			move
		end
	end
end

=begin
class Game


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