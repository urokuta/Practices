class PokerHand
  def initialize(str)
    @hands = str.split(",").map{|i| i.to_i}
  end

  def calc
    groups = @hands.group_by{|i| i}
    sizes = groups.map{|k,v| v.size}
    max, second = sizes.max(2)
    sorted = @hands.sort
    _straight = 5.times.map{|i| sorted[0]+i}
    _royal = [1, 10, 11, 12, 13]
    hand = case
           when max == 4 then "four card"
           when max == 3 && second == 2 then "full house"
           when max == 3 && second != 2 then "three card"
           when max == 2 && second == 2 then "two pair"
           when max == 2 && second != 2 then "one pair"
           when sorted == _straight || sorted == _royal then "straight"
           else "null"
           end
    return hand
  end

end

INPUT = <<EOF
1,2,3,4,1
2,3,2,3,12
12,13,11,12,12
7,6,7,6,7
3,3,2,3,3
6,7,8,9,10
11,12,10,1,13
11,12,13,1,2
EOF

INPUT.each_line do |line|
  ph = PokerHand.new(line)
  puts ph.calc
end
