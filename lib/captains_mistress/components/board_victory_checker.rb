class BoardVictoryChecker
  class << self
    def check_vertical_victory(board, player_color)
      board.each_with_index do |column, column_index|
        (board.height - (board.win_length - 1)).times do |row|
          match = true
          (board.win_length).times do |i|
            if column[row + i].disc != player_color
              match = false
            end
            if match && board.strict && column[row + board.win_length] && column[row + board.win_length].disc == player_color
              match = false
            end
          end
          return player_color if match
        end
      end
      return false
    end

    def check_horizontal_victory(board, player_color)
      # check for horizontal victory
      (board.width - (board.win_length - 1)).times do |column|
        board[column].each_with_index do |tile, row|
          match = true
          board.win_length.times do |i|
            if board[column + i][row].disc != player_color
              match = false
            end
            if match && board.strict && board[column + board.win_length] && board[column + board.win_length][row] && board[column + board.win_length][row].disc == player_color
              match = false
            end
          end
          return player_color if match
        end
      end
      return false
    end

    def check_diagonal_ur_victory(board, player_color)
      # check for diagonal (up-right) victory
      (board.width - (board.win_length - 1)).times do |column|
        (board.height - (board.win_length - 1)).times do |row|
          match = true
          board.win_length.times do |i|
            if board[column + i][row + i].disc != player_color
              match = false
            end
            if match && board.strict && board[column + board.win_length] && board[column + board.win_length][row + board.win_length] && board[column + board.win_length][row + board.win_length].disc == player_color
              match = false
            end
          end
          return player_color if match
        end
      end
      return false
    end

    def check_diagonal_dr_victory(board, player_color)
      # check for diagonal (down-right) victory
      (board.width - (board.win_length - 1)).times do |column|
        (board.height - (board.win_length - 1)).times do |row|
          match = true
          board.win_length.times do |i|
            if board[column + (board.win_length - 1 - i)][row + i].disc != player_color
              match = false
            end
            if match && board.strict && board[column - 1 - board.win_length] && board[column - 1 - board.win_length][row + board.win_length] && board[column - 1 - board.win_length][row + board.win_length].disc == player_color
              match = false
            end
          end
          return player_color if match
        end
      end
      return false
    end
  end #class methods
end #class
