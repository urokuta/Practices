class Hanoi
    def initialize
        @a = [5, 4, 3, 2, 1]
        @b = []
        @c = []
    end
    def do
        move("a", "c", @a.length)
    end

    def getArray(string)
        eval("@#{string}")
    end

    def getPlaceBeLeft(first, second)
        strings = ["a", "b", "c"]
        strings.delete(first)
        strings.delete(second)
        strings.pop
    end

    def move(from, to, num)
        p from + " to " + to
        to_a = getArray(to)
        from_a = getArray(from)
        if num == 1
            to_a.push(from_a.pop)
            p from + " to " + to + " moved!"
            self.print
            return
        end

        left = getPlaceBeLeft(from, to)
        
        move(from, left, num-1)
        to_a.push(from_a.pop)
        p from + " to " + to + " moved!"
        self.print
        move(left, to, num-1)
    end

    def print
        p "a=#{@a}, b=#{@b}, c=#{@c}"
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
