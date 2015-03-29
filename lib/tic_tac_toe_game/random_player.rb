class RandomPlayer

  attr_reader :mark

  def initialize(mark)
    @mark = mark
    puts "Random Player #{mark} initialized."
  end

  def choose_move(board)
    open_positions = board.all_open_positions
    return open_positions.sample
  end

end
