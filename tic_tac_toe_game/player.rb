class Player  

  attr_reader :mark

  def initialize(mark)
    @mark = mark
    puts "Player #{mark} initialized."
  end

  def chooseMove(board, winningCombos)
    openPositions = board.allOpenPositions()
    puts "Considering the following positions #{openPositions}."
    openPositions[rand(openPositions.length)]
  end
end
