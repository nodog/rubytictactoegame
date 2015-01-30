require 'tic_tac_toe_game/board'

describe Board do
  
  before(:each) do
    @a_board = Board.new
  end

  it 'does not catch fire when you create an instance' do
    expect(@a_board).not_to eq(nil)
  end

  it 'initializes with an empty board' do
    expect(@a_board.board_state).to eq('---------')
  end

  it 'reports all open positions' do
    @a_board = Board.new
    expect(@a_board.all_open_positions).to eq([0, 1, 2, 3, 4, 5, 6, 7, 8])
  end

  it 'adds a mark to a position' do
    @a_board.add_mark('m', 4)
    expect(@a_board.board_state).to eq('----m----')
  end

  it 'reports an empty board when empty' do
    expect(@a_board.empty_board?).to eq(true)
  end

  it 'reports a non-empty board when empty' do
    @a_board.add_mark('m', 4)
    expect(@a_board.empty_board?).to_not eq(true)
  end

  it 'creates the board state when requested' do
    expect(@a_board.string_draw).to eq("board state = ---------")
  end
  
  it 'creates the pretty board when requested' do
    expect(@a_board.pretty_board).to eq("\n - | - | - \n---+---+---\n - | - | - \n---+---+---\n - | - | - \n\n")
  end

  it 'creates a pretty board with an appropriate mark when requested' do
    @a_board.add_mark('m', 4)
    expect(@a_board.pretty_board).to eq("\n - | - | - \n---+---+---\n - | m | - \n---+---+---\n - | - | - \n\n")
  end

end
