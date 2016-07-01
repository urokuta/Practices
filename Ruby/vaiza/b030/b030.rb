class B030
  def read_input
    @coords = []
    @operations = []
    STDIN.each_line.with_index do |line,idx|
      if idx == 0
        @h, @w = line.split(" ").map(&:to_i)
      elsif idx > 0 && idx <= @h
        @coords.push(line.chomp.chars)
      elsif idx == @h+1
        @init_pos = line.split(" ").map(&:to_i)
      elsif idx == @h+2
        @num_operations = line.to_i
      else
        @operations << line.chomp
      end
    end
    @init_pos = @init_pos.map{|i| i - 1}
  end

  def calc
    @current_pos = @init_pos
    self.print_current
    @operations.each do |op|
      self.do_operation(op)
      self.print_current
    end
    print @current_pos[0] + 1
    print " "
    print @current_pos[1] + 1
  end

  def do_operation(operation)
    case operation
    when "U"
      self.move(vec_x: 0, vec_y: -1)
    when "D"
      self.move(vec_x: 0, vec_y: 1)
    when "L"
      self.move(vec_x: -1, vec_y: 0)
    when "R"
      self.move(vec_x: 1, vec_y: 0)
    end
  end

  def move(vec_x:, vec_y:)
    x = @current_pos[0] + vec_x
    y = @current_pos[1] + vec_y
    is_wall = false
    if x < 0
      x = 0
      is_wall = true
    end
    if y < 0
      y = 0
      is_wall = true
    end
    if x > @w - 1
      x = @w - 1
      is_wall = true
    end
    if y > @h - 1
      y = @h - 1
      is_wall = true
    end

    @current_pos = [x, y]
    if self.frozen? && ! is_wall
      move(vec_x: vec_x, vec_y: vec_y)
    else
    end
  end

  def frozen?
    f = self.current_floor
    if f == "#"
      true
    elsif f == "."
      false
    else
      raise "unexpected value"
    end
  end

  def current_floor
    @coords[@current_pos[1]][@current_pos[0]]
  end

  def print_current
    @coords.each_with_index do |y_line, y|
      y_line.each_with_index do |x_val, x|
        if @current_pos[0] == x && @current_pos[1] == y
          print "M"
        else
          print x_val
        end
      end
      print "\n"
    end
    puts "=================="
  end
end

b = B030.new
b.read_input
b.calc

