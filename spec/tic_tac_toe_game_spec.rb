require_relative '../tic_tac_toe_game'

describe TicTacToeGame do
  it 'doesn\'t catch fire when you create an instance' do
    expect(TicTacToeGame.new).to_not eq(nil)
  end

#   it 'allows one move' do
#     a_tic_tac_toe_game = TicTacToeGame.new
# 
#     mock_board = double("Board")
#     mock_player = double("RuleBasedPlayer")
# 
#     a_tic_tac_toe_game
# 
#     allow_any_instance_of(HumanPlayer).to receive(:mark).twice.and_return('X')
#     allow_any_instance_of(RuleBasedPlayer).to receive(:mark).and_return('X')
#     allow_any_instance_of(HumanPlayer).to receive(:choose_move).with(any_args()).and_return(4)
#     allow_any_instance_of(RuleBasedPlayer).to receive(:choose_move).with(any_args()).and_return(4)
#     allow_any_instance_of(Board).to receive(:add_mark).with('X', 4)
#     allow_any_instance_of(Board).to receive(:pretty_board).and_return('fake-pretty-board')
#     expect(a_tic_tac_toe_game).to receive(:advance_player)
#     a_tic_tac_toe_game.allow_one_move
#   end
end
