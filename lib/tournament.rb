#!/opt/local/bin/ruby1.9

require_relative 'tic_tac_toe_game'
require_relative 'tic_tac_toe_game/board'
#----------------------------------------
class Tournament

  PLAYER_1_MARK = 'X'
  PLAYER_2_MARK = 'O'

  def play(n = 100)
    winners = []
    1.upto(n) do |i|
      puts "--------------------"
      puts "TOURNAMENT GAME #{i}"
      puts "--------------------"
      #ttt_game = TicTacToeGame.new(Board.new, RuleBasedPlayer.new('X'), RuleBasedPlayer.new('O'))
      #ttt_game = TicTacToeGame.new(Board.new, RandomPlayer.new('X'), RuleBasedPlayer.new('O'))
      ttt_game = TicTacToeGame.new(Board.new, MinmaxPlayer.new('X'), RandomPlayer.new('O'))
      game_message = ttt_game.play_game
      puts
      winners << game_message[:winner]
    end

    puts "--------------------"
    puts "#{PLAYER_1_MARK} won #{winners.count(PLAYER_1_MARK)} times"
    puts "#{PLAYER_2_MARK} won #{winners.count(PLAYER_2_MARK)} times"
    puts "Game was drawn #{winners.count('draw')} times"

  end
end
# === main ===============================
if __FILE__ == $0
  tournament = Tournament.new
  tournament.play(100)
end
