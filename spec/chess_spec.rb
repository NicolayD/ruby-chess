require 'spec_helper'
require 'chess'

describe Chess do

	let(:game) { Chess.new }
	
	context '#initialize' do
		it 'creates a chess board' do
			expect(game.board).to be_a(Array)
		end
	end

	context '#swap_players' do

	end

	context '#convert_coordinates' do

	end

	context '#move' do

	end

	context '#check?' do

	end

	context '#checkmate?' do

	end

end