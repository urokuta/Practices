module CodeGolf
  # mergesort
  module Mergesort1 extend self
    def m a;(s=a.size)<2?a:(l,r=a.each_slice(s-s/2).map{|i|m i})&&r.map{|i|l.insert(l.index{|j|j>i}||l.size,i)}&&l end
  end
  # mergesort with inject
  module Mergesort2 extend self
    def m a;(s=a.size)<2?a:a.each_slice(s-s/2).map{|i|m i}.inject{|l,r|r.map{|i|l.insert(l.index{|j|j>i}||l.size,i)}&&l} end
  end
  # quicksort
  module Quicksort1 extend self
    def q a;(p=a.pop)?(l,r=a.partition{|e|e<p})&&q(l)+[p]+q(r):[] end
  end
end

rnd = (1..100).sort_by{rand}
p CodeGolf::Mergesort1.m(rnd)
p CodeGolf::Mergesort2.m(rnd)
p CodeGolf::Quicksort1.q(rnd)
