#!/opt/local/bin/ruby1.9

require 'yaml'

require_relative 'tic_tac_toe_game'
require_relative 'tic_tac_toe_game/board'
#----------------------------------------
class GameExplorer

  PLAYER_1_MARK = 'X'
  PLAYER_2_MARK = 'O'
 
  
  def catalog(filename)
    @count = 0
    @hash_of_states = {}
    
    a_board = Board.new
    generate_all_board_states(a_board)
    evaluate_all_board_states(a_board)
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
    mark_1 = PLAYER_1_MARK
    mark_2 = PLAYER_2_MARK

    generate_board_state_tree(a_board, mark_1, mark_2)
    puts "#{@count} board states"
    puts "Note that XO------- and OX------ are currently considered 2 board states."

  end

  def generate_board_state_tree(a_board, mark_1, mark_2)

    dum_char = 'x'
    @count += 1
    puts a_board.string_draw
    @hash_of_states[a_board.string_draw.to_sym] = {}
    @hash_of_states[a_board.string_draw.to_sym][:move_value] = []

    # end state 
    winner = TicTacToeGame.is_finished(a_board.board_state)
    if winner
      @hash_of_states[a_board.string_draw.to_sym][:winner] = winner[0]
      if PLAYER_1_MARK == winner
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

  def evaluate_all_board_states(a_board)
    # if this board is a winner, just return the score
    if @hash_of_states[a_board.string_draw.to_sym][:winner]
      return @hash_of_states[a_board.string_draw.to_sym][:score]
    end

    value_accum = 0

    # make a copy of the board to use and mess with
    new_board = Board.new(a_board.board_state)
    # go through all open positions for this board
    new_board.all_open_positions.each do |position|
      # add a new mark to a board
      new_board.add_mark(mark_for_this_turn(new_board), position)
      # generate the value of moving in this position
      position_value = evaluate_all_board_states(new_board)
      # accumulate for the entire set of open moves
      value_accum += position_value
      # remove the temporary mark from the board
      new_board.remove_mark(position)
      # store the value of moving in this position in an array
      @hash_of_states[new_board.string_draw.to_sym][:move_value][position] = position_value
    end
    # return the accumulation for all open positions
    value_accum
  end

  def mark_for_this_turn(a_board)
    a_board.moves_already_made().even? ? PLAYER_1_MARK : PLAYER_2_MARK
  end

end

# === main ===============================
if __FILE__ == $0
  game_explorer = GameExplorer.new
  game_explorer.catalog('catalog_tic_tac_toe.txt')
end
