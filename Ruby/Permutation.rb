class Permutation
  def initialize(x, y)
    @x = x
    @y = y
    @all = []
    @stack = []
    for i in 1..@x
      @all << i
    end
    calc(x, y, 1)
  end

  def calc(x, y, deep)
    #print "deep = #{deep}, stack = #{@stack}\n"
    if deep == x
      #print @stack.join(",") + "\n"
      @stack.pop
      return
    end
    for i in @all - @stack
      @stack << i
      calc(x, y, deep+1)
    end
    @stack.pop
  end
end
Permutation.new(10, 4)
