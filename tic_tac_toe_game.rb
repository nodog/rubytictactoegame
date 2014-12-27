#!/opt/local/bin/ruby1.9

# TicTacToeGame
# is a ruby implementation of a tic tac toe game

require_relative 'tic_tac_toe_game/board'
require_relative 'tic_tac_toe_game/rule_based_player'
require_relative 'tic_tac_toe_game/human_player'

#----------------------------------------
class TicTacToeGame

  def initialize
    @board = Board.new
    @board.screen_draw
    @player_x = HumanPlayer.new('X')
    @player_o = RuleBasedPlayer.new('O')
    @players = [@player_x, @player_o]
    @current_player = @player_x
    @game_over = false
    # winning combos 
    @winning_combos = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    @move_count = 1
    puts "tic_tac_toe_game initialized."
  end

  def play_game
    while (!is_finished) do
      allow_one_move
    end
  end

  def allow_one_move
    puts "current move is #{@move_count} and it is player #{@current_player.mark}'s turn."
    @board.add_mark(@current_player.mark, @current_player.choose_move(@board))
    @move_count += 1
    @board.screen_draw
    advance_player
  end

  def is_finished
    board_state = @board.board_state
    # two conditions for game over -- all spots filled, or 3 in a row
    # check for 3 in a row first
    @winning_combos.each do |combo|
      if (board_state[combo[0]] != @board.empty_space) \
          && (board_state[combo[0]] == board_state[combo[1]]) \
          && (board_state[combo[1]] == board_state[combo[2]])
        puts "Winner is player #{board_state[combo[0]]}!!!"
        @game_over = true
        return @game_over
      end
    end
    # check for filled board
    if board_state.index(@board.empty_space) == nil
      puts "Draw game. Boo!"
      @game_over = true
    end
    return @game_over
  end

  def advance_player
    # look up current player and move forward by one using modulus
    # This is okay for small N.
    @current_player = @players[(@players.index(@current_player) + 1) % @players.length]
  end
end

# === main ===============================
if __FILE__ == $0
  tttg = TicTacToeGame.new
  tttg.play_game
end
