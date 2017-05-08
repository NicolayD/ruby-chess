require 'spec_helper'
require 'chess.rb'

describe Chess do

	let(:game) { Chess.new }
	
	context '#initialize' do
		it 'creates a chess board' do
			expect(game.board).to be_a(Array)
		end


	end

end