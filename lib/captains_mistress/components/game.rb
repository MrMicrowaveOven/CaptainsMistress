require_relative 'player.rb'
require_relative 'party.rb'
require_relative 'board.rb'
require_relative 'user_interface.rb'

module CaptainsMistress
  class Game
    def initialize
      # height = 6, width = 7, win_length = 4, strict = false, num_players = 2

      # This is whose turn it is.  Player1's turn is 0, Player2's is 1
      @turn = 0
      play_game
    end

    def play_game
      system "clear"
      begin_game
      while true
        display_board
        puts UserInterface.turn_prompt(whose_turn.name, @board.width)
        move_made = false
        until move_made
          move = get_input
          move_made = make_move(move)
          if !move_made
            display_board
            puts UserInterface.bad_move(whose_turn.name)
            puts UserInterface.turn_prompt(whose_turn.name, @board.width)
          end
        end
        break if game_over?
        switch_turn
      end
      display_board
      puts UserInterface.victory(whose_turn.name)
      return
    end

    def display_board
      system "clear"
      puts UserInterface.game_summary(@players.length, @height, @width, @win_length, @strict)
      p @board
    end

    def begin_game
      puts UserInterface.welcome
      num_players = false
      until num_players && num_players.between?(2, 9)
        puts UserInterface.num_players_prompt
        num_players = STDIN.gets.chomp.to_i
        puts UserInterface.error_message unless num_players.between?(2, 9)
      end

      @players = Party.new
      num_players.times do |player_index|
        puts UserInterface.player_name_prompt(player_index + 1)
        player_name = STDIN.gets.chomp
        player = @players.add_player(player_index, player_name)
        puts UserInterface.player_creation_confirmation(player.color, player.name)
      end

      until @height && @height.between?(3, 30)
        puts UserInterface.height_prompt
        @height = STDIN.gets.chomp.to_i
        puts UserInterface.error_message unless @height.between?(3, 30)
      end

      until @width && @width.between?(3, 30)
        puts UserInterface.width_prompt
        @width = STDIN.gets.chomp.to_i
        puts UserInterface.error_message unless @width.between?(3, 30)
      end

      until @win_length && @win_length.between?(3, [@height, @width].max)
        puts UserInterface.win_length_prompt(@height, @width)
        @win_length = STDIN.gets.chomp.to_i
        puts UserInterface.error_message unless @width.between?(3, [@height, @width].max)
      end

      puts UserInterface.strict_prompt(@win_length)
      @strict = STDIN.gets.chomp == "y" ? true : false


      @board = Board.new(@height, @width, @win_length, @strict)



      (1..@players.length).to_a.sample.times do |i|
        switch_turn
      end

      puts "#{whose_turn.name} will go first this game."
    end

    def get_input
      column = STDIN.gets.chomp.to_i - 1
      return column
    end

    def switch_turn
      @turn += 1
      @turn -= @players.length if @turn == @players.length + 1
    end

    def whose_turn
      @players[@turn]
    end

    def make_move(column)
      # p "Making move for #{whose_turn.color}"
      @board.add_disc(column, whose_turn.color)
    end

    def game_over?
      @board.game_over?(whose_turn.color)
    end
  end
end
