num = ARGV[0]
1.upto(num.to_i) {|i|
    if i % 3 == 0 && i % 5 == 0 then
        puts "fizzbuzz"
    elsif i%3 == 0 then
        puts "fizz"
    elsif i%5 == 0 then
        puts "buzz"
    else
        #puts i
    end
}
