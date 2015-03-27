class Board
  attr_reader :board_state
  EMPTY_SPACE = '-'
  EMPTY_BOARD = EMPTY_SPACE * 9

  def initialize(a_board_state = EMPTY_BOARD.dup)
    @board_state = a_board_state
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
      if (i % 3) == 2 
        board << "\n"
        board << "---+---+---\n" if i < 8
      else
        board << "|"
      end
      i += 1
    end
    board << "\n"
  end

  def add_mark(mark, position)
    @board_state[position] = "#{mark}"
  end

  def remove_mark(position)
    @board_state[position] = EMPTY_SPACE
  end

  def moves_already_made()
    9 - board_state.chars.to_a.count(EMPTY_SPACE)
  end

  def empty_board?()
    0 == moves_already_made
  end

  def all_open_positions
    open_positions = []
    i = 0
    @board_state.split("").each do |mark|
      if mark == EMPTY_SPACE
        open_positions.push(i)
      end
      i += 1
    end
    open_positions
  end
end
