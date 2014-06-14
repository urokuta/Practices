def expr(e) e.to_s.include?("=") ? e.split[0..-2].inject([]){|arr,e| (!arr.empty? && arr.last =~ /[^\d]/) ? [eval([*arr,e].join)] : arr << e } : ->(_e){expr("#{e} #{_e}")} end
puts expr(4)["+"][3]["*"][2]["-"][1]["="]
