require 'digest/md5'
class Day4
  INPUT = "ckczppom"
  class << self
    def calc_p1
      1.upto(Float::INFINITY).each do |i|
        str = INPUT + i.to_s
        md5 = Digest::MD5.hexdigest(str)
        return i if md5[0..4] == "00000"
      end
    end

    def calc_p2
      1.upto(Float::INFINITY).each do |i|
        str = INPUT + i.to_s
        md5 = Digest::MD5.hexdigest(str)
        return i if md5[0..5] == "000000"
      end
    end
  end
end
