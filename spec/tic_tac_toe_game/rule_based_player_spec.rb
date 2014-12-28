require_relative '../../tic_tac_toe_game/rule_based_player'

describe RuleBasedPlayer do

  it 'should specify the mark when initialized' do
    a_player = RuleBasedPlayer.new('m')
    a_player.mark.should_not == nil
    a_player.mark.should == 'm'
  end

end
