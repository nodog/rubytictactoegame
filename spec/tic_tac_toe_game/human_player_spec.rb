require_relative '../../tic_tac_toe_game/human_player'

describe HumanPlayer do

  it 'should specify the mark when initialized' do
    a_player = HumanPlayer.new('m')
    a_player.mark.should_not == nil
    a_player.mark.should == 'm'
  end

end
