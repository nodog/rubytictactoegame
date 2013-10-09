#!/opt/local/bin/ruby1.9

# TicTacToeGame
# is a ruby implementation of a tic tac toe game

#----------------------------------------
class TicTacToeGame

  attr_reader :winningCombos

  def initialize
    @board = Board.new
    @board.screenDraw()
    @playerX = Player.new('X')
    @playerO = Player.new('O')
    @players = [@playerX, @playerO]
    @currentPlayer = @playerX
    @gameOver = false
    @winningCombos = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    @moveCount = 1
    puts "TicTacToeGame initialized."
  end

  def playGame
    while (!isFinished()) do
      allowOneMove()
    end
  end

  def allowOneMove
    puts "current move is #{@moveCount} and it is player #{@currentPlayer.mark}'s turn."
    @board.addMark(@currentPlayer.mark, @currentPlayer.chooseMove(@board, @winningCombos))
    @moveCount += 1
    @board.screenDraw()
    advancePlayer()
  end

  def isFinished
    boardState = @board.boardState
    # two conditions for game over -- all spots filled, or 3 in a row
    # check for 3 in a row first
    @winningCombos.each do |combo|
      if (boardState[combo[0]] != @board.emptySpace) \
          && (boardState[combo[0]] == boardState[combo[1]]) \
          && (boardState[combo[1]] == boardState[combo[2]])
        puts "Winner is player #{boardState[combo[0]]}!!!"
        @gameOver = true
        return @gameOver
      end
    end
    # check for filled board
    if boardState.index(@board.emptySpace) == nil
      puts "Draw game. Boo!"
      @gameOver = true
    end
    return @gameOver
  end

  def advancePlayer
    # look up current player and move forward by one using modulus
    # This is okay for small N.
    @currentPlayer = @players[(@players.index(@currentPlayer) + 1) % @players.length]
  end
end

#----------------------------------------
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

#----------------------------------------
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

# === main ===============================
if __FILE__ == $0
  tttg = TicTacToeGame.new
  tttg.playGame()
end
