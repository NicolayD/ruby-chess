
class Game

	attr_accessor :board, :current_player
	attr_reader :white, :black

	def initialize
		@white = { rook: "\u2656", knight: "\u2658", bishop: "\u2657", pawn: "\u2659", king: "\u2654", queen: "\u2655" }
		@black = { rook: "\u265c", knight: "\u265E", bishop: "\u265D", pawn: "\u265F", king: "\u265A", queen: "\u265B" }

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

	end

	def show_board
		@board.map do |line| 
			puts line.map { |square| square.to_s.rjust(3) }.join(" ") 
			puts
		end
	end

	def swap_players
		@current_player == :white ? :black : :white
	end

	def calculate_move x, y
		case x			# Horizontal
		when 1
			hor = 8
		when 2
			hor = 7
		when 3
			hor = 6
		when 4
			hor = 5
		when 5
			hor = 4
		when 6
			hor = 3
		when 7
			hor = 2
		when 8
			hor = 1
		end

		case y			# Vertical
		when "A"
			ver = 1
		when "B"
			ver = 2
		when "C"
			ver = 3
		when "D"
			ver = 4
		when "E"
			ver = 5
		when "F"
			ver = 6
		when "G"
			ver = 7
		when "H"
			ver = 8
		end

		array_index = [hor, ver]
	end

	def move start,finish
		start_pos = calculate_move start[0],start[1]
		end_pos = calculate_move finish[0],finish[1]
		piece = @board[start_pos[0]][start_pos[1]]
		@board[start_pos[0]][start_pos[1]] = " "
		@board[end_pos[0]][end_pos[1]] = piece
	end

end

# Sample game
#=begin
game = Game.new

game.show_board
#=end