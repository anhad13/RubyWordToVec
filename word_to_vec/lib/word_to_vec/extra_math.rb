module WordToVec
  module ExtraMath
    def vector_softmax vector
      tmp = vector.max
      vector=vector.map{|v| v-=tmp}
      vector=vector.map{|v| Math.exp(v)}
      sum=vector.inject(0){|sum,x| sum + x }
      vector.map{|v| v=v/sum}
    end
  end
end
