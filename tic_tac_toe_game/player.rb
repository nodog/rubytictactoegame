class Player  

  attr_reader :mark

  def initialize(mark)
    @mark = mark
    puts "Player #{mark} initialized."
  end

  def choose_move(board, winning_combos)
    open_positions = board.all_open_positions
    puts "Considering the following positions #{open_positions}."
    # can I win
    move = choose_winning_move_if_available(open_positions, board, winning_combos)
    if move
      return move
    end
    
    move = prevent_winning_move_if_necessary(open_positions, board, winning_combos)
    if move
      return move
    end

    move = choose_probable_winning_move(open_positions, board, winning_combos)
    if move
      return move
    end

    #choose random open position
    open_positions[rand(open_positions.length)]
  end

  def choose_winning_move_if_available(open_positions, board, winning_combos)
    open_positions.each do |position|
      winning_combos.each do |combo|
        if combo.include? position then
          if (2 == board.board_state.chars.values_at(*combo).count(@mark)) then
            puts "Found a winning move for #{@mark}."
            return position
          end
        end
      end
    end
    nil
  end

  def prevent_winning_move_if_necessary(open_positions, board, winning_combos)
    open_positions.each do |position|
      winning_combos.each do |combo|
        if combo.include? position then
          if (2 == board.board_state.chars.values_at(*combo).reject{|c| c == @mark || c == '-'}.size) then
            puts "Found a blocking move for #{@mark}."
            return position
          end
        end
      end
    end
    nil
  end


  def choose_probable_winning_move(open_positions, board, winning_combos)
    open_positions.each do |position|
      winning_combos.each do |combo|
        if combo.include? position then
          if (1 == board.board_state.chars.values_at(*combo).count(@mark)) \
             && (2 == board.board_state.chars.values_at(*combo).count('-')) then
            puts "Found a probable winning move for #{@mark}."
            return position
          end
        end
      end
    end
    nil
  end

end
