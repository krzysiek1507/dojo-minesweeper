class Minesweeper
  def initialize(input)
    @input = input
  end

  def generate
    @board = empty_board(number_of_rows,number_of_columns)
    put_bombs
    put_numbers
    MinesweeperBoardPrinter.print(@board)
  end

  private

  def put_bombs
    number_of_rows.times do |row|
      number_of_columns.times do |column|
        @board.board[row][column] = '*' if contains_bomb?(row, column)
      end
    end
  end

  def put_numbers
    number_of_rows.times do |row|
      number_of_columns.times do |column|
        @board.board[row][column] = count_surrounding_bombs(row, column).to_s unless contains_bomb?(row, column)
      end
    end
  end

  def count_surrounding_bombs(row, column)
    if contains_bomb?(row, column)
      0
    else
      bombs = 0
      (row-1..row+1).each do |r|
        (column-1..column+1).each do |c|
          bombs += 1 if contains_bomb?(r, c)
        end
      end
      bombs
    end
  end

  def contains_bomb?(row, column)
    field(row, column) == '*'
  end

  def field(row, column)
    if row<0 || row>number_of_rows-1 || column<0 || column>number_of_columns-1
      '.'
    else
      @input.lines[row + 1][column]
    end
  end

  def number_of_rows
    @input.lines[0].split[0].to_i
  end

  def number_of_columns
    @input.lines[0].split[1].to_i
  end

  def empty_board(rows, colums)
    MinesweeperBoard.new(rows,colums)
  end
end

class MinesweeperBoard
  attr_accessor :board

  def initialize(rows, columns)
    @board = Array.new(rows) { Array.new(columns, 0) }
  end
end

class MinesweeperBoardPrinter

  def self.print(board)
    board.board.map { |line| line.join }.join("\n").to_s
  end
end