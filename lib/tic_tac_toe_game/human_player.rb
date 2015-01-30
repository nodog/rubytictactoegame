class HumanPlayer

  attr_reader :mark

  def initialize(mark)
    @mark = mark
    puts "Human Player #{mark} initialized."
  end

  def choose_move(board)
    open_positions = board.all_open_positions
    valid_moves = []
    open_positions.each do |position|
      valid_moves << position.to_s
    end
    human_move = ""
    until valid_moves.include? human_move do
      puts "Human, please choose a move from the following positions: #{open_positions}."
      print "Your move? > "
      human_move = gets.chomp
      puts "Your move was: >#{human_move}<"
    end
    return human_move.to_i
  end

end
