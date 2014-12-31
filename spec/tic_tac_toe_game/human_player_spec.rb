require_relative '../../tic_tac_toe_game/human_player'

describe HumanPlayer do

  it 'should specify the mark when initialized' do
    a_player = HumanPlayer.new('m')
    a_player.mark.should == 'm'
  end

  it 'should choose a move like a human' do
    stub_board = double :all_open_positions => [0, 1]
    a_player = HumanPlayer.new('m')
    # hunh, the following line is magic to me. :P
    a_player.stub(:gets) { "0\n"}
    a_player.choose_move(stub_board).should == 0
  end
end
