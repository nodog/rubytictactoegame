require_relative '../tic_tac_toe_game'

describe TicTacToeGame do
  it 'should not catch fire when you create an instance' do
    TicTacToeGame.new().should_not == nil
  end
end
