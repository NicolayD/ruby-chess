require 'spec_helper'
require 'chess'

describe Chess do

	let(:game) { Chess.new }
	
	context '#initialize' do
		it 'creates a chess board' do
			expect(game.board).to be_a(Array)
		end

		it 'has 8 board rows and 1 index row' do
			expect(game.board.size).to eq(9)
		end

		it 'has 8 board columns and 1 index column' do
			game.board.each do |row|
				expect(row.size).to eq(9)
			end
		end

		it 'has line 8 filled with black pieces' do
			expect(game.board[1]).to_not include(" ")
			game.board[1].drop(1).each do |piece|
				expect(piece.colour).to eq(:black)
			end
		end

		it 'has line 7 filled with black pieces' do
			expect(game.board[2]).to_not include(" ")
			game.board[2].drop(1).each do |piece|
				expect(piece.colour).to eq(:black)
			end
		end

		it 'has line 2 filled with white pieces' do
			expect(game.board[7]).to_not include(" ")
			game.board[7].drop(1).each do |piece|
				expect(piece.colour).to eq(:white)
			end
		end

		it 'has line 1 filled with white pieces' do
			expect(game.board[8]).to_not include(" ")
			game.board[8].drop(1).each do |piece|
				expect(piece.colour).to eq(:white)
			end
		end

		it 'has 4 empty middle lines' do
			mid = []
			mid.push(game.board[3].drop(1))
			mid.push(game.board[4].drop(1))
			mid.push(game.board[5].drop(1))
			mid.push(game.board[6].drop(1))
			mid.flatten.each do |blank|
				expect(blank).to_not respond_to(:colour)
			end
		end

		it 'has a current player white' do
			expect(game.current_player).to eq(:white)
		end

		it 'starts with no checked king' do
			expect(game.white_checked).to be false
			expect(game.black_checked).to be false
		end

		it 'starts with a false checkmate value' do
			expect(game.checkmate).to be false
		end

		it 'starts with an empty array for all possible white moves' do
			expect(game.all_white_moves).to be_empty
		end

		it 'starts with an empty array for all possible black moves' do
			expect(game.all_black_moves).to be_empty
		end
	end

	context '#swap_players' do
		it 'swaps from white to black player' do
			expect(game.swap_players).to eq(:black)
		end

		it 'swaps from black to white player' do
			game.current_player = :black
			expect(game.swap_players).to eq(:white)
		end

	end

	context '#calculate_moves' do
		it 'calculates all possible white moves' do
			game.calculate_moves
			expect(game.all_white_moves).to_not be_empty
		end

		it 'calculates all possible black moves' do
			game.calculate_moves
			expect(game.all_black_moves).to_not be_empty
		end
	end

	context '#convert_coordinates' do
		it 'converts normal chess coordinates to board array ones' do
			expect(game.convert_coordinates("B2")).to eq([7,2])
			expect(game.convert_coordinates("H1")).to eq([8,8])
			expect(game.convert_coordinates("D7")).to eq([2,4])
			expect(game.convert_coordinates("F8")).to eq([1,6])
			expect(game.convert_coordinates("A3")).to eq([6,1])
			expect(game.convert_coordinates("C4")).to eq([5,3])
			expect(game.convert_coordinates("G5")).to eq([4,7])
			expect(game.convert_coordinates("E6")).to eq([3,5])
		end
	end

	context '#move' do
		it 'moves a white piece' do
			game.chosen_piece = game.board[7][2]
			game.move([7,2],[6,2])
			expect(game.board[6][2].colour).to eq(:white)
		end

		it 'makes the previous location of the piece blank' do
			game.chosen_piece = game.board[7][2]
			game.move([7,2],[6,2])
			expect(game.board[7][2]).to eq(" ")
		end

		it 'lets white capture black' do
			game.board[5][5] = Queen.new(:white,[5,5])
			expect(game.board[5][5].colour).to eq(:white)
			expect(game.board[2][8].colour).to eq(:black)
			game.chosen_piece = game.board[5][5]
			game.move([5,5],[2,8])
			expect(game.board[2][8].colour).to eq(:white)
		end

		it 'lets black capture white' do
			game.board[5][5] = Queen.new(:black,[5,5])
			expect(game.board[5][5].colour).to eq(:black)
			expect(game.board[7][3].colour).to eq(:white)
			game.chosen_piece = game.board[5][5]
			game.move([5,5],[7,3])
			expect(game.board[7][3].colour).to eq(:black)
		end
	end

	context '#check?' do
		it 'returns false by default' do
			expect(game.check?).to be false
		end

		it 'returns true when the king is checked' do
			game.chosen_piece = game.board[7][5] # White pawn
			game.move([7,5],[6,5])
			game.swap_players
			game.chosen_piece = game.board[2][6] # Black pawn
			game.move([2,6],[3,6])
			game.swap_players
			game.chosen_piece = game.board[8][4] # White queen
			game.move([8,4],[4,8])
			expect(game.check?).to be true
		end
	end

	context '#checkmate?' do
		it 'returns false by default' do
			expect(game.checkmate?).to be false
		end

		it 'returns true when the king is checkmated' do
			game.chosen_piece = game.board[7][6]
			game.move([7,6],[6,6])
			game.swap_players
			game.chosen_piece = game.board[2][5]
			game.move([2,5],[4,5])
			game.swap_players
			game.chosen_piece = game.board[7][7]
			game.move([7,7],[5,7])
			game.swap_players
			game.chosen_piece = game.board[1][4]
			game.move([1,4],[5,8])
			expect(game.checkmate?).to be true
		end
	end
end