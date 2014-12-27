class RuleBasedPlayer 

  PREFERRED_ORDER = [4, 0, 2, 8, 6, 1, 5, 7, 3] 
  PREFERRED_WINNING_COMBOS = [[4,0,8], [4,2,6], [0,2,1], [4,3,5], [6,8,7], [0,6,3], [4,1,7], [2,8,5]]

  attr_reader :mark

  def initialize(mark)
    @mark = mark
    puts "Rule Based Player #{mark} initialized."
  end

  def choose_move(board)
    open_positions = PREFERRED_ORDER & board.all_open_positions
    puts "Considering the following positions #{open_positions}."
    
    if board.empty_board?
      puts "Random move for #{@mark}."
      return open_positions.sample 
    end

    # can I win
    move = choose_winning_move_if_available(open_positions, board)
    return move unless move.nil?

    # can I prevent a win while creating a guaranteed win 
    move = prevent_winning_move_with_guaranteed_win(open_positions, board)
    return move unless move.nil?
    
    # something here to prefer the opposite corner if first move is in a corner?
    # the current algorithm fails without this
    
    # can I prevent a guaranteed win (does this need to be there?)
    
    # can I prevent a win while creating a probable win 
    move = prevent_winning_move_with_probable_win(open_positions, board)
    return move unless move.nil?
    
    # can I prevent a win while creating a possible win 
    move = prevent_winning_move_with_possible_win(open_positions, board)
    return move unless move.nil?
    
    # can I prevent a win at all
    move = prevent_winning_move_if_necessary(open_positions, board)
    return move unless move.nil?
    
    # can I set up a guaranteed win (two places to go next time)
    move = choose_guaranteed_winning_move(open_positions, board)
    return move unless move.nil?
    
    # can I set up a guaranteed win (two places to go next time)
    move = choose_guaranteed_winning_move(open_positions, board)
    return move unless move.nil?

    # can I line up two in a row with an empty space?
    move = choose_probable_winning_move(open_positions, board)
    return move unless move.nil?

    # can I prevent a probable vin
    move = prevent_probable_winning_move(open_positions, board)
    return move unless move.nil?

    # can I create a possible win (one mark with two empty spaces)
    move = choose_possible_winning_move(open_positions, board)
    return move unless move.nil?

    # can I prevent a possible win
    # this is the same as creating a possible win
    
    # can I move at all
    # choose random open position
    open_positions[rand(open_positions.length)]
  end

  def choose_winning_move_if_available(open_positions, board)
    open_positions.each do |position|
      PREFERRED_WINNING_COMBOS.each do |combo|
        if combo.include? position then
          if 2 == board.board_state.chars.to_a.values_at(*combo).count(@mark) then
            puts "Found a winning move for #{@mark}, #{position}."
            return position
          end
        end
      end
    end
    nil
  end

  def prevent_winning_move_with_guaranteed_win(open_positions, board)
    open_positions.each do |position|
      potential_wins = 0
      PREFERRED_WINNING_COMBOS.each do |combo|
        if combo.include? position then
          if (2 == board.board_state.chars.to_a.values_at(*combo).reject{|c| c == @mark || c == '-'}.size) then

            PREFERRED_WINNING_COMBOS.each do |combo|
              if combo.include? position then
                if (1 == board.board_state.chars.to_a.values_at(*combo).count(@mark)) \
                    && (2 == board.board_state.chars.to_a.values_at(*combo).count('-')) then
                  potential_wins += 1
                  if 2 == potential_wins then
                    puts "Found a blocking move with guaranteed win for #{@mark}, #{position}."
                    return position
                  end
                end
              end
            end

          end
        end
      end
    end
    nil
  end

  def prevent_winning_move_with_probable_win(open_positions, board)
    open_positions.each do |position|
      PREFERRED_WINNING_COMBOS.each do |combo|
        if combo.include? position then
          if (2 == board.board_state.chars.to_a.values_at(*combo).reject{|c| c == @mark || c == '-'}.size) then

            PREFERRED_WINNING_COMBOS.each do |combo|
              if combo.include? position then
                if (1 == board.board_state.chars.to_a.values_at(*combo).count(@mark)) \
                    && (2 == board.board_state.chars.to_a.values_at(*combo).count('-')) then
                  puts "Found a blocking move with probable win for #{@mark}, #{position}."
                  return position
                end
              end
            end

          end
        end
      end
    end
    nil
  end

  def prevent_winning_move_with_possible_win(open_positions, board)
    open_positions.each do |position|
      PREFERRED_WINNING_COMBOS.each do |combo|
        if combo.include? position then
          if (2 == board.board_state.chars.to_a.values_at(*combo).reject{|c| c == @mark || c == '-'}.size) then
            
            PREFERRED_WINNING_COMBOS.each do |combo|
              if combo.include? position then
                if (3 == board.board_state.chars.to_a.values_at(*combo).count('-')) then
                  puts "Found a blocking move with possible win for #{@mark}, #{position}."
                  return position
                end
              end
            end

          end
        end
      end
    end
    nil
  end

  def prevent_winning_move_if_necessary(open_positions, board)
    open_positions.each do |position|
      PREFERRED_WINNING_COMBOS.each do |combo|
        if combo.include? position then
          if (2 == board.board_state.chars.to_a.values_at(*combo).reject{|c| c == @mark || c == '-'}.size) then
            puts "Found a blocking move for #{@mark}, #{position}."
            return position
          end
        end
      end
    end
    nil
  end

  def choose_guaranteed_winning_move(open_positions, board)
    open_positions.each do |position|
      potential_wins = 0
      PREFERRED_WINNING_COMBOS.each do |combo|
        if combo.include? position then
          if (1 == board.board_state.chars.to_a.values_at(*combo).count(@mark)) \
             && (2 == board.board_state.chars.to_a.values_at(*combo).count('-')) then
            potential_wins += 1
            if 2 == potential_wins then
              puts "Found a guaranteed winning move for #{@mark}, #{position}."
              return position
            end
          end
        end
      end
    end
    nil
  end

  def choose_probable_winning_move(open_positions, board)
    open_positions.each do |position|
      PREFERRED_WINNING_COMBOS.each do |combo|
        if combo.include? position then
          if (1 == board.board_state.chars.to_a.values_at(*combo).count(@mark)) \
             && (2 == board.board_state.chars.to_a.values_at(*combo).count('-')) then
            puts "Found a probable winning move for #{@mark}, #{position}."
            return position
          end
        end
      end
    end
    nil
  end

  def prevent_probable_winning_move(open_positions, board)
    open_positions.each do |position|
      PREFERRED_WINNING_COMBOS.each do |combo|
        if combo.include? position then
          if (1 == board.board_state.chars.to_a.values_at(*combo).reject{|c| c == @mark || c == '-'}.size) \
             && (2 == board.board_state.chars.to_a.values_at(*combo).count('-')) then
            puts "Blocked a probable winning move for #{@mark}, #{position}."
            return position
          end
        end
      end
    end
    nil
  end

  def choose_possible_winning_move(open_positions, board)
    open_positions.each do |position|
      PREFERRED_WINNING_COMBOS.each do |combo|
        if combo.include? position then
          if (3 == board.board_state.chars.to_a.values_at(*combo).count('-')) then
            choice = combo.sample
            puts "Found a possible winning move for #{@mark}, #{choice}."
            return choice
          end
        end
      end
    end
    nil
  end
end
