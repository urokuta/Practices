class HitAndBlow
  attr_accessor :answer, :n
  def initialize(n)
    @n = n
    nums = (0..9).to_a.shuffle
    @answer = n.times.map{nums.pop.to_s}
  end

  def validate_input(input)
    case input
    when "q" then
      puts "bye.."
      exit
    when /^\d{#{@n}}$/ then return input.chars
    else
      puts "your input is invalid. please check your number and length : #{input}"
      return nil
    end
  end

  def match_answer(str_array)
    hit = 0
    blow = 0
    str_array.each_with_index do |c, idx|
      if answer[idx] == c
        hit += 1
        next
      elsif answer.include? c
        blow += 1
      end
    end
    {hit: hit, blow: blow}
  end

  class << self
    def go
      n = 5
      hab = self.new(n)
      puts "=== game start ==="
      puts hab.answer.inspect
      loop do
        puts "Please input your expected number."
        puts "=>"
        STDOUT.flush
        user_input = STDIN.gets
        user_input = user_input.chomp if ! user_input.nil?
        input = hab.validate_input(user_input)
        next if input.nil?
        matched = hab.match_answer(input)
        if matched[:hit] == hab.n
          puts "that's right!"
          break
        else
          puts "your anwser is wrong. : #{user_input.count} #{user_input.class}, #{user_input.keys}"
          puts matched.inspect
        end
        STDOUT.flush
      end
    end
  end
end

HitAndBlow.go
