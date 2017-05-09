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
			expect(game.white_checked).to be_false
			expect(game.black_checked).to be_false
		end

		it 'starts with a false checkmate value' do
			expect(game.checkmate).to be_false
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
			expect(game.convert_coordinates("2B")).to eq([7,2])
			expect(game.convert_coordinates("1H")).to eq([8,8])
			expect(game.convert_coordinates("7D")).to eq([2,4])
			expect(game.convert_coordinates("8F")).to eq([1,6])
			expect(game.convert_coordinates("3A")).to eq([6,1])
			expect(game.convert_coordinates("4C")).to eq([5,3])
			expect(game.convert_coordinates("5G")).to eq([4,7])
			expect(game.convert_coordinates("6E")).to eq([3,5])
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

		it 'can capture enemy pieces' do
			game.board[5][5] = Queen.new(:white,[5,5])
			expect(game.board[5][5].colour).to eq(:white)
			expect(game.board[2][8].colour).to eq(:black)
			game.chosen_piece = game.board[5][5]
			game.move([5,5],[2,8])
			expect(game.board[2][8].colour).to eq(:white)
		end
	end

	context '#check?' do

	end

	context '#checkmate?' do

	end

end