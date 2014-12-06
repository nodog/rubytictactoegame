class Board
  attr_reader :boardState
  attr_reader :emptySpace

  def initialize
    @emptySpace = '-'
    @boardState = @emptySpace * 9
    puts "Board initialized."
  end
  
  def stringDraw
    puts "board state = #{@boardState}"
  end
  
  def screenDraw
    print "\n"
    i = 0
    @boardState.split("").each do |mark|
      print " "
      print "#{mark}"
      print " " 
      if ((i % 3) != 2) 
        print "|"
      else
        print "\n"
        print "---+---+---\n" if i < 8
      end
      i += 1
    end
    print "\n"
  end

  def addMark(mark, position)
    @boardState[position] = "#{mark}"
  end

  def allOpenPositions()
    openPositions = []
    i = 0
    @boardState.split("").each do |mark|
      if (mark == @emptySpace)
        openPositions.push(i)
      end
      i += 1
    end
    return openPositions
  end
end
