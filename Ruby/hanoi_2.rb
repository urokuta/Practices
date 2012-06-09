class Hanoi
    def initialize
        @tower = {}
        @tower["a"] = [5, 4, 3, 2, 1]
        @tower["b"] = []
        @tower["c"] = []
    end

    def do
        move("a", "c", @tower["a"].length)
    end

    def move(from, to, num)
        p from + " to " + to
        if num == 1
            @tower[to].push(@tower[from].pop)
            p from + " to " + to + " moved!"
            self.print
            return
        end

        left = (["a", "b", "c"] - [from, to]).pop
        
        move(from, left, num-1)
        @tower[to].push(@tower[from].pop)
        p from + " to " + to + " moved!"
        self.print
        move(left, to, num-1)
    end

    def print
        p "a=#{@tower["a"]}, b=#{@tower["b"]}, c=#{@tower["c"]}"
    end
end

    
    
    
hanoi = Hanoi.new
hanoi.do

=begin
    def do
        moveAtoB(@a.length-1)
        @c.push(@a.pop)
        moveBtoC(@b.length)
    end

    def moveAtoB(num)
        moveAtoC(num-1)
        @b.push(@a.pop)
        moveCtoB(@c.length)
    end

    def moveAtoC(num)
        moveAtoB(num-1)
        



def main()
  hanoi.a = [5, 4, 3, 2, 1]
  hanoi.b = []
  hanoi.c = []
  moveAtoB(hanoi, hanoi.a.length-1)
  hanoi.c.push(hanoi.a.pop)
  moveBtoC(hanoi, hanoi.b.length)
end

def moveAtoB(hanoi, num)
  moveAtoC(hanoi, num-1)
  hanoi.b.push(hanoi.a.pop)
  moveCtoB(hanoi, hanoi.c.length)
end

def moveAtoC(hanoi, num)
  moveAtoB(hanoi,  num-1)
  c.push(a.pop)
  moveBtoC(a, b, c, b.length)
end

def moveBtoC(a, b, c, num)
    moveBtoA(a, b, c, num-1)
    c.push(b.pop)
    moveAtoC(a, b, c, a.length)
end

def moveCtoB(a, b, c, num)
    moveCtoA(a, b, c, num-1)
    b.push(c.pop)
    moveAtoB(a, b, c, a.length)
=end
