class B022
  def read_input
    @speech_orders = []
    STDIN.each_line.with_index do |line,idx|
      if idx == 0
        @num_candidates, @num_users, @num_lines = line.split(" ").map{|i| i.to_i}
      else
        @speech_orders << line.chomp.to_i
      end
    end
    @speech_orders = @speech_orders.reverse
    @candidate_users = {}
    1.upto(@num_candidates) do |c|
      @candidate_users[c] = 0
    end
  end

  def do_speech
    target = @speech_orders.pop
    if @num_users > 0
      @num_users -= 1
      @candidate_users[target] += 1
    end
    1.upto(@num_candidates) do |c|
      if @candidate_users[c] > 0
        @candidate_users[c] -= 1
        @candidate_users[target] += 1
      end
    end
  end

  def calc
    @num_lines.times do |i|
      self.do_speech
    end
    max_candidate_val = 0
    target = nil
    max_item = @candidate_users.to_a.max_by{|i| i[1]}
    max_value = max_item[1]
    @candidate_users.to_a.select{|i| i[1] == max_value}.map{|i| i[0]}
  end
end

b = B022.new
b.read_input
puts b.calc
