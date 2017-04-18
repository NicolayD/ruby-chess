require_relative 'board.rb'

class Game

	attr_accessor :board, :current_player

	white_player = { rook: "\u2656", knight: "\u2658", bishop: "\u2657", pawn: "\u2659", king: "\u2654", queen: "\u2655" }
	black_player = { rook: "\u265c", knight: "\u265E", bishop: "\u265D", pawn: "\u265F", king: "\u265A", queen: "\u265B" }

	def initialize
		@board = Board.new
		@current_player = :white
	end

	def swap_players
		@current_player == :white ? :black : :white
	end

end

# Sample game
=begin
board = Board.new

board.show_board
=end