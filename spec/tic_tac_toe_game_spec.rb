require_relative '../tic_tac_toe_game'

describe TicTacToeGame do
  it 'doesn\'t catch fire when you create an instance' do
    expect(TicTacToeGame.defaults).to_not eq(nil)
  end

  it 'allows one move' do
    a_tic_tac_toe_game = TicTacToeGame.new(Board.new, RuleBasedPlayer.new('x'), RuleBasedPlayer.new('o'))
    expect(a_tic_tac_toe_game).to receive(:advance_player)
    a_tic_tac_toe_game.allow_one_move
  end
end
