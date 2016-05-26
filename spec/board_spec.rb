require_relative '../lib/captains_mistress.rb'
require_relative '../lib/captains_mistress/components/board.rb'
require_relative '../lib/captains_mistress/components/tile.rb'

describe "Board" do
  before :each do
    @board = CaptainsMistress::Board.new
    @board.add_disc(3,1)
  end

  it "has appropriate height and width" do
    expect(@board.height).to eq(6)
    expect(@board.width).to eq(7)
  end

  describe "lowest_empty_tile" do
    it "returns 0 with empty column" do
      expect(@board.lowest_empty_tile(0)).to eq(0)
    end
    it "returns 1 if column has one disc in it" do
      expect(@board.lowest_empty_tile(3)).to eq(1)
    end
  end

  describe "winner" do
    it "returns nil if no winner" do
      expect(@board.winner(1)).to eq(nil)
    end
    it "returns 1 if player 1 has four vertical in a row" do
      @board.add_disc(3,1)
      @board.add_disc(3,1)
      @board.add_disc(3,1)
      expect(@board.winner(1)).to eq(1)
    end
    it "returns 1 if player 1 has four horizontal in a row (row 0)" do
      @board.add_disc(2,1)
      @board.add_disc(4,1)
      @board.add_disc(5,1)
      expect(@board.winner(1)).to eq(1)
    end
    it "returns 1 if player 1 has four horizontal in a row (row 1)" do
      # fill row zero
      @board.add_disc(2,2)
      @board.add_disc(4,2)
      @board.add_disc(5,2)

      # make four in a row for player 1 on row one
      @board.add_disc(3,1)
      @board.add_disc(2,1)
      @board.add_disc(4,1)
      @board.add_disc(5,1)
      expect(@board.winner(1)).to eq(1)
    end
    it "returns 1 if player 1 has four diagonal (top-right) in a row" do
      # make a triangle of player 2 discs
      @board.add_disc(4,2)
      @board.add_disc(5,2)
      @board.add_disc(5,2)
      @board.add_disc(6,2)
      @board.add_disc(6,2)
      @board.add_disc(6,2)

      # make player 1 discs rest on triangle
      @board.add_disc(4,1)
      @board.add_disc(5,1)
      @board.add_disc(6,1)
      expect(@board.winner(1)).to eq(1)
    end
    it "returns 1 if player 1 has four diagonal (bottom-right) in a row" do
      # make a triangle of player 2 discs
      @board.add_disc(0,2)
      @board.add_disc(0,2)
      @board.add_disc(0,2)
      @board.add_disc(1,2)
      @board.add_disc(1,2)
      @board.add_disc(2,2)

      # make player 1 discs rest on triangle
      @board.add_disc(0,1)
      @board.add_disc(1,1)
      @board.add_disc(2,1)
      expect(@board.winner(1)).to eq(1)
    end

  end
end
