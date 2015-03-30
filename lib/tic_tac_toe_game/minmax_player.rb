require 'yaml'

require_relative '../tic_tac_toe_game/board'
#require_relative '../tic_tac_toe_game'

class MinmaxPlayer

  attr_reader :mark

  def initialize(mark)
    @hash_of_states = {}
    begin
      filename = 'catalog_tic_tac_toe.txt'
      file = File.open(filename, "r")
      yaml = file.read()
      @hash_of_states = YAML.load(yaml)
    rescue IOError => e
      #some error occur, dir not writable etc.
    ensure
      file.close unless file == nil
    end
    @mark = mark
    puts "Minmax Player #{mark} initialized."
  end

  def choose_move(board)
    board_string = board.string_draw
    puts board_string
    mark_p1 = TicTacToeGame::PLAYER_1_MARK 
    move_values = @hash_of_states[board_string.to_sym][:move_value]
    puts move_values
    if mark_p1 == @mark
      desired_move_value = move_values.compact.max
    else
      desired_move_value = move_values.compact.min
    end
    desired_move_indices = move_values.each_index.select{|i| move_values[i] == desired_move_value}
    return desired_move_indices.sample
  end

end
