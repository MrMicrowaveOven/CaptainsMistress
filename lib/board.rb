require_relative 'tile.rb'
require_relative 'board_victory_checker.rb'

module CaptainsMistress
  class Board
    attr_reader :height, :width, :win_length, :strict
    def initialize(height = 6, width = 7, win_length = 4, strict = false)
      @board = Array.new(width) {Array.new(height) {Tile.new}}
      @height = height
      @width = width
      @win_length = win_length
      @strict = strict
    end

    def each_with_index(&prc)
      @board.each_with_index(&prc)
    end

    def [](column)
      @board[column]
    end

    def add_disc(column, disc_color)
      return false unless lowest_empty_tile(column)
      @board[column][lowest_empty_tile(column)].disc = disc_color
      return true
    end

    def game_over?(player_color)
      winner(player_color) != nil
    end

    def winner(player_color)
      victory = check_vertical_victory(player_color)
      return victory if victory
      victory = check_horizontal_victory(player_color)
      return victory if victory
      victory = check_diagonal_ur_victory(player_color)
      return victory if victory
      victory = check_diagonal_dr_victory(player_color)
      return victory if victory
      return nil
    end

    # this tile is important, as it will decide where a disc goes.
    def lowest_empty_tile(column)
      return false unless column <= width - 1 && column >= 0
      # column.between?(1, width)
      lowest = 0
      # Go through each row until you find an empty tile
      @board[column].each_with_index do |tile, row|
        if !tile.filled?
          return row
        end
      end
      # If column is full, just return false
      return false
    end

    def inspect
      # Each element of board_display will be a row
      board_display = Array.new(height, "")
      @board.each do |column|
        column.each_with_index do |tile, row|
          # tile_show = tile.disc
          board_display[row] += "| #{tile.to_s} |"
        end
      end
      header = "     "
      width.times do |col|
        header += "#{(col + 1).to_s}   "
        header += " " if col < 9
      end
      header += "    "
      puts header
      # puts "   ___________________________________"
      puts ""
      board_display.reverse.each do |row|
        puts "   #{row}   "
      end
      return
    end

    private

    def tile_show(disc)
      return " " if !disc
      disc
      # return "X" if disc == 1
      # return "O" if disc == 2
    end

    def check_vertical_victory(player_color)
      BoardVictoryChecker.check_vertical_victory(self, player_color)
    end

    def check_horizontal_victory(player_color)
      BoardVictoryChecker.check_horizontal_victory(self, player_color)
    end

    def check_diagonal_ur_victory(player_color)
      BoardVictoryChecker.check_diagonal_ur_victory(self, player_color)

    end

    def check_diagonal_dr_victory(player_color)
      BoardVictoryChecker.check_diagonal_dr_victory(self, player_color)
    end

  end
end
