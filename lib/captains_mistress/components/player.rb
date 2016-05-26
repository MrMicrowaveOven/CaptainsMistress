module CaptainsMistress
  class Player
    attr_reader :color, :name
    def initialize(color, name = "Player")
      @color = color
      @name = name
    end
  end
end
