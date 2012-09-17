require "pp"
module Global_Sudoku
  @@coords = []

  def search
    @@coords.each do |key_y, y|
      y.each do |key_x, x|
        yield x, y
      end
    end
  end

  def output
    @@coords.each do |key_y, y|
      y.each do |key_x, x|
        print x.num
      end
      print "\n"
    end
    puts ""
  end
  
  def custom_output(num=1)
    @@coords.each do |key_y, y|
      y.each do |key_x, x|
        pp x if x.possibles.size < num
      end
      print "\n"
    end
    puts ""
  end
end

class Number
  attr_accessor :num, :x, :y, :group, :possibles, :is_fixed, :try_count
  include Global_Sudoku

  def initialize(number, x, y, group, is_fixed)
    @num = number
    @x = x
    @y = y
    @group = group
    if is_fixed
      @possibles = [number]
    else
      @possibles = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    end
    @is_fixed = is_fixed
    @try_count = 0
  end

  def get_area_numbers(area)
    result = []
    search do |x, y|
      case area
      when :row
        result.push x if x.y == @y
      when :column
        result.push x if x.x == @x
      when :group
        result.push x if x.group == @group
      end
    end
    result
  end

  def overlap_number?
    rows = get_area_numbers(:row)
    columns = get_area_numbers(:column)
    group = get_area_numbers(:group)
    
    rows.each {|num| return true if num != self && num.num == @num }
    columns.each {|num| return true if num != self && num.num == @num }
    group.each {|num| return true if num != self && num.num == @num }
    false
  end
  
  def before
    @before = _before
    if @before.is_fixed == true
      @before.before
    else
      @before
    end
  end
  
  def _before
    if @x <= 0 && @y <= 0
      raise "error!"
    elsif @x == 0 && @y > 0 
      @@coords[@y-1][8]
    else
      @@coords[@y][@x-1]
    end
  end
 
  
  def next
    @next = _next
    if @next.is_fixed == true
      @next.next
    else
      @next
    end
  end
 
  def _next
    if @x >= 8 && @y >= 8
      output
      exit
    elsif @x == 8 && @y < 8 
      @@coords[@y+1][0]
    else
      @@coords[@y][@x+1]
    end
  end

end

class Sudoku
  include Global_Sudoku
  def initialize
    @@coords = Hash.new { |hash,key| hash[key] = {} }
    input = set_problem
    input.each_line.with_index do |line, idx_y|
      line.each_byte.with_index do |str, idx_x|
        group = 1 if (idx_y >= 0 and idx_y < 3 and idx_x >= 0 and idx_x < 3)
        group = 2 if (idx_y >= 0 and idx_y < 3 and idx_x >= 3 and idx_x < 6)
        group = 3 if (idx_y >= 0 and idx_y < 3 and idx_x >= 6 and idx_x < 9)
        group = 4 if (idx_y >= 3 and idx_y < 6 and idx_x >= 0 and idx_x < 3)
        group = 5 if (idx_y >= 3 and idx_y < 6 and idx_x >= 3 and idx_x < 6)
        group = 6 if (idx_y >= 3 and idx_y < 6 and idx_x >= 6 and idx_x < 9)
        group = 7 if (idx_y >= 6 and idx_y < 9 and idx_x >= 0 and idx_x < 3)
        group = 8 if (idx_y >= 6 and idx_y < 9 and idx_x >= 3 and idx_x < 6)
        group = 9 if (idx_y >= 6 and idx_y < 9 and idx_x >= 6 and idx_x < 9)
        next if str.chr == "\n"
        if str.chr == "0"
          is_fixed = false
        else
          is_fixed = true
        end
        @@coords[idx_y][idx_x] = Number.new(str.chr.to_i, idx_x, idx_y, group, is_fixed)
      end
    end
  end

  def get_group_numbers(num)
    result = []
    search do |x, y|
      result.push x if x.group == num
    end
    result
  end


  def fill_impossibles
    search do |x, y|
      if x.is_fixed
        rows = x.get_area_numbers(:row)
        columns = x.get_area_numbers(:column)
        group = x.get_area_numbers(:group)

        rows.each {|number|
          number.possibles.delete(x.num)
        }
        columns.each {|number| number.possibles.delete(x.num)}
        group.each {|number| number.possibles.delete(x.num)}
      end
    end
  end
  
  def group_possibility_check
    (1..9).each do |num|
      group = get_group_numbers(num)
      (1..9).each do |_num|
        nums = []
        group.each do |g_num|
            nums.push({:num => _num, :data => g_num}) if g_num.possibles.include?(_num)
        end
        if nums.size == 1
          ok = nums.pop
          ok[:data].num = ok[:num]
          ok[:data].is_fixed = true
        end
      end
    end
  end

  def brute
    @stack_count = 0
    search do |x, y|
      if !x.is_fixed
        @pointer = x
        break
      end
    end
    _loop
    output

  end

  def _loop
    _brute
    if @stack_count >= 5000
      @stack_count = 0
      _loop
    end
  end

  def _brute
    @stack_count += 1
    if @stack_count >= 5000
      return
    end
    @pointer.num = @pointer.possibles[@pointer.try_count]
    is_max_tried = @pointer.try_count == @pointer.possibles.size
    if @pointer.overlap_number? || is_max_tried
      if is_max_tried
        @pointer.try_count = 0
        @pointer.num = 0
        @pointer = @pointer.before
      end
      @pointer.try_count += 1
    else
      @pointer = @pointer.next
    end
    _brute
  end

  def start_calc
    fill_impossibles
    group_possibility_check
    brute
  end
  
  def set_problem
<<EOS
005300000
800000020
070010500
400005300
010070006
003200080
060500009
004000030
000009700
EOS
  end
end

test = Sudoku.new
test.output
test.start_calc
