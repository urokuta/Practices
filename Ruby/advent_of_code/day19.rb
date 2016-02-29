class Day19
  INPUT = "CRnCaSiRnBSiRnFArTiBPTiTiBFArPBCaSiThSiRnTiBPBPMgArCaSiRnTiMgArCaSiThCaSiRnFArRnSiRnFArTiTiBFArCaCaSiRnSiThCaCaSiRnMgArFYSiRnFYCaFArSiThCaSiThPBPTiMgArCaPRnSiAlArPBCaCaSiRnFYSiThCaRnFArArCaCaSiRnPBSiRnFArMgYCaCaCaCaSiThCaCaSiAlArCaCaSiRnPBSiAlArBCaCaCaCaSiThCaPBSiThPBPBCaSiRnFYFArSiThCaSiRnFArBCaCaSiRnFYFArSiThCaPBSiThCaSiRnPMgArRnFArPTiBCaPRnFArCaCaCaCaSiRnCaCaSiRnFYFArFArBCaSiThFArThSiThSiRnTiRnPMgArFArCaSiThCaPBCaSiRnBFArCaCaPRnCaCaPMgArSiRnFYFArCaSiThRnPBPMgAr"
  class << self
    CONVERTERS = <<EOS
l => ThF
Al => ThRnFAr
B => BCa
B => TiB
B => TiRnFAr
Ca => CaCa
Ca => PB
Ca => PRnFAr
Ca => SiRnFYFAr
Ca => SiRnMgAr
Ca => SiTh
F => CaF
F => PMg
F => SiAl
H => CRnAlAr
H => CRnFYFYFAr
H => CRnFYMgAr
H => CRnMgYFAr
H => HCa
H => NRnFYFAr
H => NRnMgAr
H => NTh
H => OB
H => ORnFAr
Mg => BF
Mg => TiMg
N => CRnFAr
N => HSi
O => CRnFYFAr
O => CRnMgAr
O => HP
O => NRnFAr
O => OTi
P => CaP
P => PTi
P => SiRnFAr
Si => CaSi
Th => ThCa
Ti => BP
Ti => TiTi
e => HF
e => NAl
e => OMg
EOS


    def calc_p2
      results = []
      converters.each do |hash|
        k = hash.to_a[0][0]
        v = hash.to_a[0][1]
        puts "k: #{k}, v: #{v}"
        idx = 0
        loop do
          idx = INPUT.index(k, idx)
          puts idx
          break if idx == nil
          results << create_replaced_str(INPUT, idx, k, v)
          idx += 1
        end
      end
      results.uniq.count
    end

    def do_convert(input, from, to)
      k = from
      v = to
      idx = 0
      results = []
      loop do
        idx = input.index(k, idx)
        break if idx == nil
        results << create_replaced_str(input, idx, k, v)
        puts "idx: #{idx}, k: #{k}, v:#{v}"
        idx += 1
      end
      results
    end

    def create_replaced_str(input, idx, from, replaced)
      if idx == 0
        head = ""
      else
        head = input[0..idx-1]
      end
      if input.size == 1
        bottom = ""
      else
        bottom = input[idx+from.size..-1]
      end
      head + replaced + bottom
    end

    def calc_p
      results = [INPUT]
      converters.each do |k,v|
        puts "k: #{k}, v: #{v} results: #{results.count}"
        v.each do |con|
          _results = []
          results.each do |r|
            _results << r.gsub(k, con[1])
          end
          results += _results
          results.uniq!
        end
      end
      results.count
    end

    def calc_p3
#       do_convert("HF", "H", "CRnAlAr")
      results = [INPUT]
      results = replace_all(results, r_converters_ar)
      results = r_once_converts(results)
      results = replace_all(results, r_converters_ar)
      results = r_once_converts(results)
      results = replace_all(results, r_converters_ar)
    end

    def once_converts(input)
      results = []
      converters.each do |con|
        input.each do |i|
          results += do_convert(i, con[0], con[1])
        end
      end
      results.uniq
    end

    def r_once_converts(input)
      results = []
      r_converters.each do |con|
        input.each do |i|
          results += do_convert(i, con[0], con[1])
        end
      end
      results.uniq
    end

    def r_ar_once_converts(input)
      results = []
      r_converters_ar.each do |con|
        input.each do |i|
          results += do_convert(i, con[0], con[1])
        end
      end
      results.uniq
    end
    
    def replace_all(input, cons)
      input.map do |i|
        replaced = i
        cons.each do |con|
          replaced = replaced.gsub(con[0], con[1])
        end
        replaced
      end
    end

    def r_converters
      converters.map{|c|[c[1], c[0]]}
    end

    def r_converters_ar
      r_converters.select{|c| c[0].include?("Ar")}
    end

    def converters
      cons = CONVERTERS.each_line.map do |line|
        k, v = line.chomp.split(" => ")
        [k, v]
      end
    end
  end
end
