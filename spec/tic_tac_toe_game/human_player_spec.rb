require_relative '../../tic_tac_toe_game/human_player'

describe HumanPlayer do

  it 'should specify the mark when initialized' do
    a_player = HumanPlayer.new('m')
    a_player.mark.should == 'm'
  end

  it 'should choose a move like a human' do
    stub_board = double :all_open_positions [0, 1]
    a_player = HumanPlayer.new('m')
    # this is wrong
    #stub_IO = double :gets '0'
    #a_player.choose_move(stub_board).should == 0
    a_player.zmove(stub_board).should == 0
  end
end
