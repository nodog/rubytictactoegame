require 'tic_tac_toe_game/rule_based_player'

describe RuleBasedPlayer do

  it 'should specify the mark when initialized' do
    a_player = RuleBasedPlayer.new('m')
    expect(a_player.mark).to eq('m')
  end

end
