class S002
  VECS = [
    [1, 0],
    [-1, 0],
    [0, 1],
    [0, -1],
  ]
  def read_input
    @coords = []
    @w, @h = gets.chomp.split(" ").map(&:to_i)
    STDIN.each_line.with_index do |line,idx|
      coord = line.chomp.split(" ")
      if coord.include?("s")
        @start_pos = [coord.index("s"), idx]
      end
      if coord.include?("g")
        @goal_pos = [coord.index("g"), idx]
      end
      @coords.push(coord)
    end
  end

  def calc
    # puts "@coords: #{@coords}, @start_pos: #{@start_pos}, @goal_pos: #{@goal_pos}"
    history = [@start_pos]
    result_values = VECS.map do |vec|
      self.search(@start_pos, vec, history.clone, 1)
    end
    result = result_values.compact.min
    if result.nil?
      return "Fail"
    else
      return result
    end
  end

  def search(current_pos, vec, history, counter)
    new_pos = [current_pos[0] + vec[0], current_pos[1] + vec[1]]
    # puts "============================="
    # puts "new_current: #{new_pos}, old: #{current_pos}, history: #{history}, counter: #{counter}"
    x, y = new_pos
    if x < 0 || x > @w - 1
      return nil
    end
    if y < 0 || y > @h - 1
      return nil
    end
    if history.include?(new_pos)
      return nil
    end
    floor = @coords[y][x]
    case floor
    when "1"
      return nil
    when "0"
      counter += 1
      history << new_pos
      result = VECS.map do |vec|
        search(new_pos, vec, history.clone, counter)
      end
      return result.compact.min
    when "g"
      return counter
    else
      raise "unexpected error value: #{floor}"
    end
  end
end

s = S002.new
s.read_input
puts s.calc
