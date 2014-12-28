class Board
  attr_reader :board_state
  attr_reader :empty_space

  def initialize
    @empty_space = '-'
    @board_state = @empty_space * 9
    puts "Board initialized."
  end
  
  def string_draw
    "board state = #{@board_state}"
  end
  
  def pretty_board
    board = "\n"
    i = 0
    @board_state.split("").each do |mark|
      board << " "
      board << "#{mark}"
      board << " " 
      unless  (i % 3) == 2 
        board << "|"
      else
        board << "\n"
        board << "---+---+---\n" if i < 8
      end
      i += 1
    end
    board << "\n"
  end

  def add_mark(mark, position)
    @board_state[position] = "#{mark}"
  end

  def empty_board?()
    if (9 == board_state.chars.to_a.count('-')) then
      return true 
    else
      return nil
    end
  end

  def all_open_positions
    open_positions = []
    i = 0
    @board_state.split("").each do |mark|
      if mark == @empty_space
        open_positions.push(i)
      end
      i += 1
    end
    return open_positions
  end
end
