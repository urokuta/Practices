class C014
  def read_input
    @lengths = []
    STDIN.each_line.with_index do |line,idx|
      if idx == 0
        @n, @r = line.split(" ").map{|i| i.to_i}
      else
        @lengths << line.split(" ").map{|i| i.to_i}
      end
    end
  end

  def calc
    @results = []
    @lengths.each_with_index do |ls,idx|
      flg = true
      ls.each do |l|
        flg = false if @r*2 > l
      end
      if flg
        @results << idx+1
      end
    end
    @results
  end
end
c = C014.new
c.read_input
puts c.calc
