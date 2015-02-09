#!/opt/local/bin/ruby1.9

require 'yaml'

require_relative 'tic_tac_toe_game'
require_relative 'tic_tac_toe_game/board'
#----------------------------------------
class GameExplorer
  
  def catalog(filename)
    @count = 0
    @hash_of_states = {}
    @base_mark = 'X'
    a_board = Board.new
    generate_all_board_states(a_board)
    begin
      file = File.open(filename, "w")
      file.write(YAML.dump(@hash_of_states))
    rescue IOError => e
      #some error occur, dir not writable etc.
    ensure
      file.close unless file == nil
    end
  end

  def generate_all_board_states(a_board)

    # generate a hash with board states as keys in order to list scores (eventually)
    mark_1 = @base_mark
    mark_2 = 'O'

    generate_board_state_tree(a_board, mark_1, mark_2)
    puts "#{@count} board states"
    puts "Note that X-------- and O------- are currently considered 2 board states."

  end

  def generate_board_state_tree(a_board, mark_1, mark_2)

    dum_char = 'x'
    @count += 1
    puts a_board.string_draw
    @hash_of_states[a_board.string_draw.to_sym] = {}

    # end state 
    winner = TicTacToeGame.is_finished(a_board.board_state)
    if winner
      @hash_of_states[a_board.string_draw.to_sym][:winner] = winner[0]
      if winner == @base_mark
        score = 1
      elsif 'draw' == winner
        score = 0
      else
        score = -1
      end
      @hash_of_states[a_board.string_draw.to_sym][:score] = score
      return score
    end

    # go through all open positions for this mark

    new_board = Board.new(a_board.board_state)
    new_board.all_open_positions.each do |position|
      new_board.add_mark(mark_1, position)
      t = generate_board_state_tree(new_board, mark_2, mark_1)
      new_board.remove_mark(position)
    end

  end

end

# === main ===============================
if __FILE__ == $0
  game_explorer = GameExplorer.new
  game_explorer.catalog('catalog_tic_tac_toe.txt')
end
