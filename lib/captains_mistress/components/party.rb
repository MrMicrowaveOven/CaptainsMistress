require_relative 'player.rb'

module CaptainsMistress
  class Party
    def initialize
      @players = []
    end

    def add_player(color, name)
      player = Player.new(color, name)
      @players << player
      player
    end

    def [](player_number)
      # This allows us to give Player1 an index of 1, and so on
      @players[player_number - 1]
    end

    def length
      @players.length
    end
  end
end
