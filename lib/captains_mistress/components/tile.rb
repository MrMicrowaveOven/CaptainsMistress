module CaptainsMistress
  class Tile
    # The Tiles make up the board
    attr_accessor :disc
    def initialize(disc = nil)
      @disc = disc
    end

    def filled?
      disc
    end

    def to_s
      return " " unless disc
      disc
    end
  end
end
