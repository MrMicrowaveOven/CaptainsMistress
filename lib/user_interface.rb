class UserInterface
  class << self
    def welcome
      "Welcome to Captain's Mistress!"
    end

    def num_players_prompt
      "How many players will be playing this game? (Minimum is 2, maximum is 9)"
    end

    def player_name_prompt(player_number)
      "What would you like Player#{player_number}'s name to be?"
    end

    def player_creation_confirmation(player_number, player_name)
      "Okay.  Player#{player_number + 1}'s name is #{player_name}."
    end

    def error_message
      "Oops, that input is invalid.  Please try again."
    end

    def height_prompt
      "What would you like the height of the game to be? (Minimum is 3, maximum is 30)"
    end

    def width_prompt
      "What would you like the width of the game to be? (Minimum is 3, maximum is 30)"
    end

    def win_length_prompt(height, width)
      "What would you like the win length of the game to be? (Minimum is 3, max is #{[height, width].max})"
    end

    def strict_prompt(win_length)
      "Would you like the game to be strict, which requires exactly #{win_length} required to win?  Otherwise you will need AT LEAST #{win_length} to win. (type 'y' or 'n')"
    end

    def game_summary(num_players, height, width, win_length, strict)
      "Okay.  This will be a game between #{num_players} players.  Game will be of height #{height}, width #{width}, and #{strict ? "exactly" : "at least"} #{win_length} in a row is required to win."
    end

    def turn_prompt(name, width)
      "#{name}'s turn.  Choose a column (1 - #{width}) to place a disc."
    end

    def bad_move(name)
      "Oops, that move isn't valid.  Try again!"
    end

    def victory(name)
      "#{name} wins!"
    end
  end #class methods
end #class
