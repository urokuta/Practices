require 'open3'
class HitAndBlowBot
end

puts "here"
stdin, stdout, stderr = *Open3.popen3("ruby ./hit_and_blow.rb")

stdout.each do |line|
  puts line
#   if line.chomp == "=>"
    puts "come"
    puts "come"
#     next
#   end
  puts "here#{__LINE__}"
  puts "here#{__LINE__}"
  stdin.puts "67890\n"
end
stdin.puts "67890\n"
stdin.flush
stdout.each do |line|
  puts line
end
