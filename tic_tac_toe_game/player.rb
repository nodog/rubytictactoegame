class Player  

  attr_reader :mark

  def initialize(mark)
    @mark = mark
    puts "Player #{mark} initialized."
  end

  def choose_move(board)
    open_positions = board.all_open_positions
    puts "Considering the following positions #{open_positions}."
    puts "Random move for #{@mark}."
    return open_positions.sample 
  end
end
