require 'time'
class B004
  def read_input
    @lines = []
    STDIN.each_line.with_index do |line,idx|
      if idx == 0
        @ip = line.chomp
      elsif idx == 1
        @num_lines = line.chomp
      else
        items = line.gsub(/("[^"]*) ([^"]*")/, '\1|\2').gsub(/("[^"]*) ([^"]*")/, '\1|\2').split(" ")
        file = items[5].split("|")[1]
        date_str = items[3][1..-1]
        format = "%d/%b/%Y:%H:%M:%S"
        date = Time.strptime(date_str, format)
        result = {ip: items[0], date_str: date_str, file_name: file, date: date}
        @lines << result
      end
    end
  end

  def calc
    i1, i2, i3, i4 = @ip.split(".")
    @results = []
    @lines.each do |line|
      t1, t2, t3, t4 = line[:ip].split(".")
      next if i1 != t1
      next if i2 != t2
      next if ! B004.in_range?(i3, t3)
      next if ! B004.in_range?(i4, t4)
      @results << line
    end
    @results = @results.sort_by{|i| i[:date]}.map{|i| [i[:ip], i[:date_str], i[:file_name]]}
    @results.each do |r|
      str = r.join(" ")
      print str + "\n"
    end
  end

  class << self
    def in_range?(range_str, target)
      if range_str.include?("[")
        range_str = range_str.gsub("[", "").gsub("]", "")
        first, last = range_str.split("-").map{|i| i.to_i}
        range = Range.new(first, last)
        range.include?(target.to_i)
      elsif range_str.include?("*")
        true
      else
        range_str == target
      end
    end
  end
end

b = B004.new
b.read_input
b.calc
