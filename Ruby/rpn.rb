def expr(e, stack=[], rpn=[])
  case e
  when "="
    rpn += stack.reverse
    puts rpn.to_s
    return rpn.inject([]) do |arr, token|
        case token.to_s
        when /[-+*\/]/ then arr << arr.pop(2).inject($&)
        when /\d+/ then arr << $&.to_f
        end
    end.shift
  when /[-+*\/]/
    case e
    when /[*\/]/ then stack << e
    else
      rpn += stack.reverse;stack = [e]
    end
  else rpn << e
  end
  ->(e){expr(e, stack, rpn)}
end

puts expr(4).("+").(3).("*").(2).("-").(1).("=")
puts expr(1).("*").(2).("+").(6).("/").(3).("=")
puts expr(1).("+").(2).("+").(6).("/").(3).("=")
