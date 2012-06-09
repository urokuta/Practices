class InverseFizzBuzz
  def initialize(input)
    @input = input
    @result = []
    @basic_set = self.calcShortestMap
    length = {}
    @basic_set.each{|key, value|length[key] = value.length}
    @length_set = length
    pp self._is_valid?(input)
  end

  def createSeq
    seq = []
    1.upto(15){|i|
      (i..15).inject([]){|result, j|
        result << j
        seq.push result.clone
        result
      }
    }
    seq
  end

  def fizzbuzz(input)
    first = input.first
    last = input.last
    result = []
    first.upto(last){|i|
      array = []
      array << :fizz if i%3 == 0
      array << :buzz if i%5 == 0
      result.push array * "," if array.size > 0
    }
    result != [] ? result : nil
  end
  def calcMap
    seq = self.createSeq
    map = {}
    seq.each{|arr|
      fb = self.fizzbuzz(arr)
      map[fb].class == Array ? map[fb] << arr : map[fb] = [arr]
    }
    map
  end

  def calcShortestMap
    map = self.calcMap
    newMap = {}
    map.each{|key, value|
      #firstly, sort the length of array and sort the number of array. At last return first value of array
      newMap[key.join(" ")] = value.sort{|a,b| (a.size == b.size) ? a[0] <=> b[0] : a.size <=> b.size}[0] if key != nil
    }
    newMap
  end
  
  def _is_valid_set?(input)
    @basic_set.key?(input)
  end

  def _is_valid?(input)
    input = input.join(" ")
    #definitely false "buzz fizz,buzz" and "fizz,buzz buzz" and "fizz,buzz fizz,buzz"
    return false if input.include?("buzz fizz,buzz") || input.include?("fizz,buzz buzz") || input.include?("fizz,buzz fizz,buzz") 
    input.split("fizz,buzz").each{|i|
      return false if !self._is_valid_set?(i)
    }
    true
  end
  def calc
    @input = @input.join(" ")


  end

end
require "pp"
ifb = InverseFizzBuzz.new(["fizz", "fizz", "buzz"])
ifb.createSeq
#print ifb.seq.count
#print ifb.fizzbuzz((3..9))
#pp ifb.calcShortestMap
#FizzBuzz.new(100)
