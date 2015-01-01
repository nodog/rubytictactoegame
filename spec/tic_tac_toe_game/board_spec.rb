require_relative '../../tic_tac_toe_game/board'

describe Board do
  
  before :each do
    @a_board = Board.new()
  end

  it 'should not catch fire when you create an instance' do
    expect(@a_board).not_to eq(nil)
  end

  it 'should initialize with an empty board' do
    expect(@a_board.board_state).to eq('---------')
  end

  it 'should add a mark to a position' do
    @a_board.add_mark('m', 4)
    expect(@a_board.board_state).to eq('----m----')
  end

  it 'should report all open positions' do
    expect(@a_board.all_open_positions).to eq([0, 1, 2, 3, 4, 5, 6, 7, 8])
  end

  it 'should report an empty board when empty' do
    expect(@a_board.empty_board?).to eq(true)
  end

  it 'should report a non-empty board when empty' do
    @a_board.add_mark('m', 4)
    expect(@a_board.empty_board?).to eq(nil)
  end

  it 'should create the board state when requested' do
    expect(@a_board.string_draw).to eq('board state = ---------')
  end
  
  it 'should create the pretty board when requested' do
    expect(@a_board.pretty_board).to eq("\n - | - | - \n---+---+---\n - | - | - \n---+---+---\n - | - | - \n\n")
  end

  it 'should create a pretty board with an appropriate mark when requested' do
    @a_board.add_mark('m', 4)
    expect(@a_board.pretty_board).to eq("\n - | - | - \n---+---+---\n - | m | - \n---+---+---\n - | - | - \n\n")
  end

end
