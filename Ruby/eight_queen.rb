class EightQueen
  class Board
    attr_accessor :n
    attr_accessor :queens
    def initialize(n, queens: [])
      @board = Array.new(n){Array.new(n, "B")}
      @n = @board.count
      @queens = []
      queens.each{|q| put_queen(*q)}
    end

    def put_queen(x, y)
      puts "x: #{x}, y: #{y}"
      fill_y(x, "X")
      fill_x(y, "X")
      fill_slant_right_up(x, y, "X")
      fill_slant_right_down(x, y, "X")

      @board[x][y] = "Q"
      @queens << [x, y]
      @board
    end

    def fill_y(x, value)
      @board[x] = Array.new(@n, value)
    end

    def fill_x(y, value)
      @board = @board.map{|row| row[y] = value;row}
    end

    def fill_slant_right_up(x, y, value)
      _fill_slant(x, y, value, +1)
    end

    def fill_slant_right_down(x, y, value)
      _fill_slant(x, y, value, -1)
    end

    def _fill_slant(x, y, value, operator)
      for _x in 0...@n
        idx = y - (( x - _x) * operator)
        next if idx > @n - 1 || idx < 0
        @board[_x][idx] = value
      end
    end

    def output
      puts "----- current board -----"
      @board.reverse.each do |y|
        y.each do |x|
          print x
        end
        puts ""
      end
      puts "-----     end     -----"
    end

    def can_put_queen?(x, y)
      return true if @board[x][y] == "B"
      return false
    end
  end

  def create_board(n)
    Array.new(n){Array.new(n, nil)}
  end

  # return queens
  def find(board, x, y)
#     puts "x: #{x}, y: #{y}"
    n = board.n
    return board if x == n
#     board.output
    if board.can_put_queen?(x, y)
      board.put_queen(x, y)
      find(board, x+1, 0)
    else
      if y == n
        last_queen_y = board.queens.last[1]
        removed_queens = board.queens[0...-1]
        board = Board.new(n, queens: removed_queens)
        find(board, x-1, last_queen_y+1)
      else
        find(board, x, y+1)
      end
    end
  end

  def calc
    n = 8
    board = Board.new(n)
    x = 0
    y = 0
    board = find(board, x, y)
    board.output
  end

  def test
    board = Board.new(5, queens: [[1, 1], [2, 3], [3, 0]][0...-1])
    board.output
  end
end

eq = EightQueen.new
eq.calc
# eq.calc
