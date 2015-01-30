#!/opt/local/bin/ruby1.9

require_relative 'tic_tac_toe_game'
require_relative 'tic_tac_toe_game/board'
#----------------------------------------
class GameExplorer
  
  def catalog(filename)
    @count = 0
    a_board = Board.new
    begin
      file = File.open(filename, "w")
      file.write(generate_all_board_states(a_board))
    rescue IOError => e
      #some error occur, dir not writable etc.
    ensure
      file.close unless file == nil
    end
  end

  def generate_all_board_states(a_board)

    # generate a hash with board states as keys in order to list scores (eventually)
    hash_of_states = {} 
    mark_1 = 'X'
    mark_2 = 'O'

    generate_board_state_tree(a_board, hash_of_states, mark_1, mark_2)
    puts "#{@count} board states"
    puts "Note that X-------- and O------- are currently considered 2 board states."

  end

  def generate_board_state_tree(a_board, hash_of_states, mark_1, mark_2)

    dum_char = 'x'
    @count += 1
    puts a_board.string_draw
    b_board = Board.new(a_board.board_state.tr(mark_1, dum_char).tr(mark_2, mark_1).tr(dum_char, mark_2))
    puts b_board.string_draw

    # end state 
    if TicTacToeGame.is_finished(a_board.board_state)
      return 
    end

    # go through all open positions for this mark

    new_board = Board.new(a_board.board_state)
    new_board.all_open_positions.each do |position|
      new_board.add_mark(mark_1, position)
      t = generate_board_state_tree(new_board, hash_of_states, mark_2, mark_1)
      new_board.remove_mark(position)
    end

  end

end

# === main ===============================
if __FILE__ == $0
  game_explorer = GameExplorer.new
  game_explorer.catalog('catalog_tic_tac_toe.txt')
end
