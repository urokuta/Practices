class PerfectPrime
  def prime?(num)
    return false if num == 1
    num.times.each do |i|
      next if i == 0 || i == 1
      return false if num % i == 0
    end
    return true
  end

  def check_perfect_prime?(num)
    target = num
    num.size.times do |i|
      return false if ! prime?(target)
      target = num.to_s[0..i].to_i
    end
    true
  end

  def calc
    init = [2, 3, 5, 7]
    additionals = [1, 3, 7, 9]
    results = []
    init.each do |i|
      recursive(i, additionals, results)
    end
    results
  end

  def recursive(init_num, additionals, results)
    puts "init_num: #{init_num}, additionals = #{additionals}, results = #{results}"
    additionals.each do |a|
      target = (init_num.to_s + a.to_s).to_i
      result = check_perfect_prime?(target)
      if result
        results << target
        recursive(target, additionals, results)
      end
    end
  end
end

pp = PerfectPrime.new
puts pp.check_perfect_prime?(31)
puts pp.check_perfect_prime?(599)
puts pp.check_perfect_prime?(100)
puts pp.calc.sort
