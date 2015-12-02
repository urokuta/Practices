module CodeGolf
  # mergesort
  module MergeSort1
    def m a;(s=a.size)<2?a:(l,r=a.each_slice(s-s/2).map{|i|m(i)})&&r.map{|i|l.insert(l.index{|j|j>i}||l.size,i)}&&l end
  end
  # mergesort with inject
  module MergeSort2
    def m a;(s=a.size)<2?a:a.each_slice(s-s/2).map{|i|m(i)}.inject{|l,r|r.map{|i|l.insert(l.index{|j|j>i}||l.size,i)}&&l} end
  end
  # quicksort
  module Quicksort1
    def q a;(p=a.pop)?(l,r=a.partition{|e|e<p})&&q(l)+[p]+q(r):[] end
  end
end
