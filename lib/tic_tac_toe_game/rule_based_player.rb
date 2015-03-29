class RuleBasedPlayer 

  PREFERRED_ORDER = [4, 0, 2, 8, 6, 1, 5, 7, 3] 
  PREFERRED_WINNING_COMBOS = [[4,0,8], [4,2,6], [0,2,1], [4,3,5], [6,8,7], [0,6,3], [4,1,7], [2,8,5]]
  OUTER_RING = [0, 1, 2, 3, 5, 6, 7, 8]
  CORNERS = [0, 2, 8, 6]

  attr_reader :mark

  def initialize(mark)
    @mark = mark
    puts "Rule Based Player #{mark} initialized."
  end

  def choose_move(board)
    open_positions = PREFERRED_ORDER & board.all_open_positions
    puts "Considering the following positions #{open_positions}."

    move = nil
    
    if board.empty_board?
      puts "Random move for #{@mark}."
      move = open_positions.sample 
    end

    move = move \
        || choose_winning_move_if_available(open_positions, board) \
        || choose_adjacent_side_if_opponet_first_outer_ring_is_corner(open_positions, board) \
        || prevent_winning_move_with_guaranteed_win(open_positions, board) \
        || prevent_winning_move_with_probable_win(open_positions, board) \
        || prevent_winning_move_with_possible_win(open_positions, board) \
        || prevent_winning_move_if_necessary(open_positions, board) \
        || choose_guaranteed_winning_move(open_positions, board) \
        || choose_guaranteed_winning_move(open_positions, board) \
        || choose_probable_winning_move(open_positions, board) \
        || prevent_probable_winning_move(open_positions, board) \
        || choose_possible_winning_move(open_positions, board) \
        || open_positions.sample

    return move

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

  def choose_adjacent_side_if_opponet_first_outer_ring_is_corner(open_positions, board)
    # is the outer ring open except for one opponent move
    if (1 == board.board_state.chars.to_a.values_at(*OUTER_RING).reject{|c| c == '-'}.size) \
        && ( 0 == board.board_state.chars.to_a.values_at(*OUTER_RING).count(@mark))
      # is the one opponent move in a corner
      if (1 == board.board_state.chars.to_a.values_at(*CORNERS).reject{|c| c == '-'}.size) 
        # move adjacent on side
        index_in_corners = board.board_state.chars.to_a.values_at(*CORNERS).find_index {|c| c!= '-'} 
        adjacent_on_side = CORNERS[ index_in_corners ] < 4 ? 1 : 7 
        return adjacent_on_side
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
