require_relative '../../tic_tac_toe_game/human_player'

describe HumanPlayer do

  it 'specifies the mark when initialized' do
    a_player = HumanPlayer.new('m')
    expect(a_player.mark).to eq('m')
  end

  it 'chooses a move like a human' do
    mock_board = instance_double("Board")
    expect(mock_board).to receive(:all_open_positions).and_return([0, 1])

    a_player = HumanPlayer.new('m')
    expect(a_player).to receive(:gets) { "1\n"}
    expect(a_player.choose_move(mock_board)).to eq(1)
  end
end
