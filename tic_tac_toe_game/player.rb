class Player  

  attr_reader :mark

  def initialize(mark)
    @mark = mark
    puts "Player #{mark} initialized."
  end

  def choose_move(board, winning_combos)
    open_positions = board.all_open_positions
    puts "Considering the following positions #{open_positions}."
    open_positions[rand(open_positions.length)]
  end
end
