#!/opt/local/bin/ruby1.9

# TicTacToeGame
# is a ruby implementation of a tic tac toe game

require_relative 'tic_tac_toe_game/board'
require_relative 'tic_tac_toe_game/rule_based_player'
require_relative 'tic_tac_toe_game/human_player'
require_relative 'tic_tac_toe_game/random_player'
require_relative 'tic_tac_toe_game/minmax_player'

#----------------------------------------
class TicTacToeGame

  WINNING_COMBOS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

# suggestions from Adrien - 
# THIS - to get defaults in  
#   class gamething
# 
#     def self.defaults
#       gamething.new(humanplayer.new, blaplayer.new)
#     end
# 
# 
#     def initialize(x, y)
#       @x = x
#     end
#   end
#
# GameThing.defaults
  
  def self.defaults
    TicTacToeGame.new(Board.new, RuleBasedPlayer.new('X'), MinmaxPlayer.new('O'))
  end

# AND THIS  should have whatever values as arguments so I can test it
  def initialize(board, player_x, player_o) 
    @board = board
    puts @board.pretty_board
    @player_x = player_x
    @player_o = player_o
    @players = [@player_x, @player_o]
    @current_player = @player_x
    # winning combos 
    @move_count = 1
    puts "tic_tac_toe_game initialized."
  end

  def play_game
    winner = nil
    until winner = TicTacToeGame.is_finished(@board.board_state) do
      allow_one_move
    end
    puts "Winner is #{winner}!!!"
  end

  def allow_one_move
    puts "current move is #{@move_count} and it is player #{@current_player.mark}'s turn."
    @board.add_mark(@current_player.mark, @current_player.choose_move(@board))
    @move_count += 1
    puts @board.pretty_board
    advance_player
  end

  def TicTacToeGame.is_finished(board_state)
    # two conditions for game over -- all spots filled, or 3 in a row
    game_winner = nil
    # check for 3 in a row first
    WINNING_COMBOS.each do |combo|
      if (board_state[combo[0]] != Board::EMPTY_SPACE) \
          && (board_state[combo[0]] == board_state[combo[1]]) \
          && (board_state[combo[1]] == board_state[combo[2]])
        #puts "Winner is player #{board_state[combo[0]]}!!!"
        game_winner = board_state[combo[0]]
        return game_winner
      end
    end
    # check for filled board
    if board_state.index(Board::EMPTY_SPACE) == nil
      game_winner = 'draw'
    end
    return game_winner
  end

  def advance_player
    # look up current player and move forward by one using modulus
    # This is okay for small N.
    @current_player = @players[(@players.index(@current_player) + 1) % @players.length]
  end
end

# === main ===============================
if __FILE__ == $0
  tttg = TicTacToeGame.defaults
  tttg.play_game
end
