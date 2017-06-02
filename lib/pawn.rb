require_relative 'moves'

class Pawn
	include Moves
	attr_accessor :symbol, :colour, :position, :possible_moves

	def initialize colour,position
		@colour = colour
		@position = position			# The position is going to look like [5,6] which represents the 5 row and 6 column
		if @colour == :white
			@symbol = "\u2659"
		elsif @colour == :black
			@symbol = "\u265F"
		end

		@possible_moves = []
	end

	# Create an array with all possible moves such as [[3,3],[4,5], etc.] 
	def possible_moves board,position=self.position
		hor = position[0].to_i
		ver = position[1].to_i
		@possible_moves = []

		if self.colour == :white
			@possible_moves.push [hor-1,ver] if board[hor-1][ver] == " "
			@possible_moves.push [hor-2,ver] if hor == 7 && board[hor-2][ver] == " "
			@possible_moves.push [hor-1,ver-1] if enemy? board,hor-1,ver-1
			@possible_moves.push [hor-1,ver+1] if enemy? board,hor-1,ver+1
		elsif self.colour == :black
			@possible_moves.push [hor+1,ver] if board[hor+1][ver] == " "
			@possible_moves.push [hor+2,ver] if hor == 2 && board[hor+2][ver] == " "
			@possible_moves.push [hor+1,ver-1] if enemy? board,hor+1,ver-1
			@possible_moves.push [hor+1,ver+1] if enemy? board,hor+1,ver+1
		end
		@possible_moves
	end

	def promote board
		hor = self.position[0]
		ver = self.position[1]
		if self.colour == :white && hor == 1
			puts "You must promote your pawn."
			puts "Queen, knight, rook or bishop?"
			choice = gets.chomp
			choices = ["queen", "knight", "rook", "bishop"]
			until choices.include? choice.downcase
				puts "You must choose a proper piece."
				choice = gets.chomp
			end
			case choice.downcase
			when "queen" then board[hor][ver] = Queen.new(:white,[hor,ver])
			when "knight" then board[hor][ver] = Knight.new(:white,[hor,ver])
			when "rook" then board[hor][ver] = Rook.new(:white,[hor,ver])
			when "bishop" then board[hor][ver] = Bishop.new(:white,[hor,ver])
			end
		end

		if self.colour == :black && hor == 8
			puts "You must promote your pawn."
			puts "Queen, knight, rook or bishop?"
			choice = gets.chomp
			choices = ["queen", "knight", "rook", "bishop"]
			until choices.include? choice.downcase
				puts "You must choose a proper piece."
				choice = gets.chomp
			end
			case choice.downcase
			when "queen" then board[hor][ver] = Queen.new(:black,[hor,ver])
			when "knight" then board[hor][ver] = Knight.new(:black,[hor,ver])
			when "rook" then board[hor][ver] = Rook.new(:black,[hor,ver])
			when "bishop" then board[hor][ver] = Bishop.new(:black,[hor,ver])
			end
		end
	end
end
