require_relative '../tic_tac_toe_game'

describe TicTacToeGame do
  it 'doesn\'t catch fire when you create an instance' do
    expect(TicTacToeGame.new).to_not eq(nil)
  end

  it 'allow one move' do
    a_tic_tac_toe_game = TicTacToeGame.new
    expect(a_tic_tac_toe_game).to_receive :advance_player
    a_tic_tac_toe_game.allow_one_move
  end
end
