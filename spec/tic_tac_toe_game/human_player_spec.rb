require_relative '../../tic_tac_toe_game/human_player'

describe HumanPlayer do

  it 'should specify the mark when initialized' do
    a_player = HumanPlayer.new('m')
    expect(a_player.mark).to eq('m')
  end

  it 'should choose a move like a human' do
    stub_board = instance_double("Board", :all_open_positions => [0, 1])
    a_player = HumanPlayer.new('m')
    # hunh, the following line is magic to me. :P
    allow(a_player).to receive(:gets) { "1\n"}
    expect(a_player.choose_move(stub_board)).to eq(1)
  end
end
