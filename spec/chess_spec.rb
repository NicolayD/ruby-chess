require 'spec_helper'
require 'chess.rb'

describe Game do

	let(:game) { Game.new }
	
	context '#initialize' do
		it 'creates a chess board' do
			expect(game.board).to be_a(Array)
		end

		it 'creates a board with black figures' do
			expect(game.board[1]).to eq([8,  "\u265c","\u265E","\u265D","\u265B","\u265A","\u265D","\u265E","\u265c"])
			expect(game.board[2]).to eq([7,  "\u265F","\u265F","\u265F","\u265F","\u265F","\u265F","\u265F","\u265F"])
		end

		it 'creates a board with white figures' do
			expect(game.board[7]).to eq([2,  "\u2659","\u2659","\u2659","\u2659","\u2659","\u2659","\u2659","\u2659"])
			expect(game.board[8]).to eq([1,  "\u2656","\u2658","\u2657","\u2655","\u2654","\u2657","\u2658","\u2656"])
		end

		it 'doesn\'t create other pieces' do
			expect(game.board[3]).to eq([6,  " "," "," "," "," "," "," "," "])
			expect(game.board[4]).to eq([5,  " "," "," "," "," "," "," "," "])
			expect(game.board[5]).to eq([4,  " "," "," "," "," "," "," "," "])
			expect(game.board[6]).to eq([3,  " "," "," "," "," "," "," "," "])
		end

		it 'has a current player' do
			expect(game.current_player).not_to be_nil
		end

		it 'has a white current player by default' do
			expect(game.current_player).to eq(:white)
		end
	end

	context '#swap_players' do
		it 'changes from white to black' do
			game.current_player = :white
			expect(game.swap_players).to eq(:black)
		end

		it 'changes from black to white' do
			game.current_player = :black
			expect(game.swap_players).to eq(:white)
		end
	end

	context '#calculate_move' do
		it 'creates index for a two-dim array from normal chess indices' do
			x = 2
			y = "D"
			expect(game.calculate_move(x,y)).to eq([7,4])
		end
	end

	context '#move' do

		it 'moves a white pawn if current player is white' do
			x = [2, "D"]			# White rook
			y = [3, "D"]
			expect(game.move(x,y)).to eq("\u2659")
		end

		it 'moves a black pawn if current player is black' do
			x = [7, "F"]			# Black rook
			y = [6, "F"]
			expect(game.move(x,y)).to eq("\u265F")
		end

		it 'correctly removes the piece from the original place' do
			x = [2, "D"]			# [7][4] in the board array
			y = [3, "D"]
			game.move(x,y)
			expect(game.board[7][4]).to eq(" ")
		end

		it 'correctly moves the piece to the new place' do
			x = [2, "D"]			
			y = [3, "D"]			# [6][4] in the board array
			game.move(x,y)
			expect(game.board[6][4]).to eq("\u2659")
		end

		context 'pawn' do
			it 'moves only forward by one tile' do
				x = [2, "G"]			# [7][4] in the board array
				y = [3, "F"]
				expect(game.move(x,y)).to be_false
			end

			it 'can move diagonally if adjacent to enemy piece' do
				sample_board = [["","A","B","C","D","E","F","G","H"],
							[8,  "\u265c","\u265E","\u265D","\u265B","\u265A","\u265D","\u265E","\u265c"],
							[7,  "\u265F","\u265F","\u265F","\u265F","\u265F","\u265F","\u265F","\u265F"],
							[6,  " "," "," "," "," ","\u2659"," "," "],
							[5,  " "," "," "," "," "," "," "," "],
							[4,  " "," "," "," "," "," "," "," "],
							[3,  " "," "," "," "," "," "," "," "],
							[2,  "\u2659","\u2659"," ","\u2659","\u2659","\u2659","\u2659","\u2659"],
						  [1,  "\u2656","\u2658","\u2657","\u2655","\u2654","\u2657","\u2658","\u2656"]]
				x = [6, "F"]
				y = [7, "E"]
				expect(game.move(x,y)).to eq("\u2659")
				y = [7, "G"]
				expect(game.move(x,y)).to eq("\u2659")
			end
		end

	end


end