class Day10
  INPUT = "111221"
  class << self
    def calc_p1
      target = INPUT
      40.times.each do |i|
        puts i
        target = look_and_say(target)
      end
      target.size
    end

    def look_and_say(str)
      same_chars = []
      last_char = nil
      result_str = ""
      str.chars.each do |s|
        if last_char.nil? || last_char == s
          same_chars << s
          last_char = s
        else
          result_str << same_chars.count.to_s
          result_str << same_chars.first
          same_chars = [s]
          last_char = s
        end
      end
      result_str << same_chars.count.to_s
      result_str << same_chars.first
      result_str
    end
  end
end

puts Day10.calc_p1
