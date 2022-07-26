class Game
  attr_reader :size
  def initialize(size=3)
    @size = size
    @board = Array.new(@size) {|i| Array.new(@size, i)}
    board_placement = 1
    @board.each_with_index do |row, i|
      row.each_with_index do |_column, x|
        @board[i][x] = board_placement
        board_placement += 1
      end
    end
  end

  private

  def sideways_board
    sideways_board = []
    (0...@size).each do |column|
      sideways_row = []
      (0...@size).each do |row|
        sideways_row.push(@board[row][column])
      end
      sideways_board.push(sideways_row)
    end
    sideways_board
  end

  def diagonal_board
    diagonal_board = []

    left_diagonal = []
    right_diagonal = []
    (0...@size).each do |i|
      left_diagonal.push(@board[i][i])
      right_diagonal.push(@board[i][@size - i - 1])
    end
    diagonal_board.push(left_diagonal, right_diagonal)

    diagonal_board
  end

  def col_unique?(board)
    board.each do |row|
      # row win
      return true if row.uniq.size <= 1
    end
    false
  end

  public

  def print
    @board.each { |row| p row }
  end

  def not_taken?(placement)
    column = (placement.to_i - 1) / @size
    row = (placement - 1) % @size
    @board[column][row].is_a? Integer
  end

  def move(placement, symbol)
    return unless placement.is_a? Integer

    column = (placement.to_i - 1) / @size
    row = (placement - 1) % @size

    @board[column][row] = symbol
  end

  def win?
    sideways = sideways_board
    diagonals = diagonal_board
    col_unique?(sideways) || col_unique?(@board) || col_unique?(diagonals)
  end

  def tie?
    @board.flatten.uniq.size == 2
  end

  def end(player)
    print
    if win?
      puts "#{player.name} is the winner!"
    else
      puts "It's a tie!"
    end
  end
end