require "pp"

class Puyo
  attr_accessor :x, :y, :type, :erase_flag, :checked
  @@coords
  @@color
  @@count

  def initialize(x, y, symbol)
    @x = x
    @y = y
    @type = symbol
    @erase_flag = false
    @checked = false
  end

  def self.set_coords(coords)
    @@coords = coords
  end

  def check_erase
    erased = false
    @@color = @type
    @@count = 0
    @@items = []
    _check_erase
    if @@count == 4
      @@items.each do |item|
        item.erase_flag = true
        erased = true
      end
    end
    erased
  end

  def erase
    erased = false
    if @erase_flag == true
      @type = :none
      @erase_flag = false
      if @y-1 >= 0
        up = @@coords[@y-1][@x]
        if up.type != :none
          @type = up.type
          @erase_flag = false
          up.type = :none
          up.erase_flag = true
          erased = true
        else
          up.erase_flag = false
        end
      end
    end
    erased
  end 

  def self.output
    @@coords.each do |key_y, y|
      y.each do |key_x, x|
        case x.type
        when :none
          print " "
        else
          print x.type
        end
      end
      print "\n"
    end
    puts ""
  end

  def _check_erase
    raise "error!!2" if @erase_flag == true
    if @type == :none
      raise "none error"
    else @type == @@color
      @@count += 1
      @@items.push self
    end
    @checked = true
    check_items = []

    begin
      check_items.push(@@coords[@y-1][@x]) if @y-1 >= 0
      check_items.push(@@coords[@y+1][@x])
      check_items.push(@@coords[@y][@x-1]) if @x-1 >= 0
      check_items.push(@@coords[@y][@x+1])
    rescue
      puts "error!"
      exit
    end

    check_items.each do |item|
      if !item.nil? && item.type == @@color && item.checked == false
        item._check_erase
      end 
    end
  end
end

class SolvePuyo
  def initialize
    @coords = Hash.new { |hash,key| hash[key] = {} }
    input = set_problem
    input.each_line.with_index do |line, idx_y|
      line.each_byte.with_index do |str, idx_x|
        type = :none
        case str.chr
        when " "
          @type = :none
        when "\n"
          next
        else
          @type = str.chr
        end
        @coords[idx_y][idx_x] = Puyo.new(idx_x, idx_y, @type)
      end
    end
    Puyo.set_coords(@coords)
  end

  def reset_check
    @coords.each do |key, y|
      y.each do |key, x|
        x.checked = false
      end
    end
  end

  def erase_phase
    @coords.each do |key, y|
      y.each do |key, x|
        if x.erase
          erase_phase
        end
      end
    end
  end

  def start_calc
    @coords.each do |key, y|
      y.each do |key, x|
        if x.type == :none
          next
        else
          if x.check_erase
            reset_check
            erase_phase
            Puyo.output
            start_calc
          end
        end
      end
    end
  end

  def set_problem
<<EOF
  GYRR 
RYYGYG 
GYGYRR 
RYGYRG 
YGYRYG 
GYRYRG 
YGYRYR 
YGYRYR 
YRRGRG 
RYGYGG 
GRYGYR 
GRYGYR 
GRYGYR
      
EOF
  end
end

puyo = SolvePuyo.new()
puyo.start_calc
