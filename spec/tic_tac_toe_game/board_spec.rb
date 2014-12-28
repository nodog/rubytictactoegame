require_relative '../../tic_tac_toe_game/board'

describe Board do
  
  before :each do
    @a_board = Board.new()
  end

  it 'should not catch fire when you create an instance' do
    @a_board.should_not == nil
  end

  it 'should initialize with an empty board' do
    @a_board.board_state.should == '---------'
  end

  it 'should add a mark to a position' do
    @a_board.add_mark('m', 4)
    @a_board.board_state.should == '----m----'
  end

  it 'should report all open positions' do
    @a_board.all_open_positions.should == [0, 1, 2, 3, 4, 5, 6, 7, 8]
  end

  it 'should report an empty board when empty' do
    @a_board.empty_board?.should == true
  end

  it 'should report a non-empty board when empty' do
    @a_board.add_mark('m', 4)
    @a_board.empty_board?.should == nil
  end

  it 'should create the board state when requested' do
    @a_board.string_draw.should == 'board state = ---------'
  end
  
  it 'should create the pretty board when requested' do
    @a_board.pretty_board.should == "\n - | - | - \n---+---+---\n - | - | - \n---+---+---\n - | - | - \n\n"
  end

  it 'should create a pretty board with an appropriate mark when requested' do
    @a_board.add_mark('m', 4)
    @a_board.pretty_board.should == "\n - | - | - \n---+---+---\n - | m | - \n---+---+---\n - | - | - \n\n"
  end

end
