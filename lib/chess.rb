require_relative 'board.rb'

class Game

	attr_accessor :board

	white_player = { rook: "\u2656", knight: "\u2658", bishop: "\u2657", pawn: "\u2659", king: "\u2654", queen: "\u2655" }
	black_player = { rook: "\u265c", knight: "\u265E", bishop: "\u265D", pawn: "\u265F", king: "\u265A", queen: "\u265B" }

	def initialize
		@board = Board.new
	end


end

board = Board.new

board.show_board