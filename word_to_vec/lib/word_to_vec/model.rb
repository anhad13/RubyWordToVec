module WordToVec
  class Model < Struct.new(:inputV, :outputV, :vocab)
    include ::WordToVec::ExtraMath
    def print_inputV word
      token_id=self.vocab[word.downcase]
      raise Exception, "Word not in vocabulary" if token_id.nil?
      self.inputV.row_vectors[token_id]
    end
    def print_outputV word
      token_id=self.vocab[word.downcase]
      raise Exception, "Word not in vocabulary" if token_id.nil?
      self.outputV.row_vectors[token_id]
    end
    def closest word
      token1=self.vocab[word]
      raise Exception, "Word not in vocabulary" if token1.nil?
      max=-999999
      res_w=nil.to_s
      self.vocab.each do |word2, token2|
        next if token1==token2
        value=WordRepresentation.euclidean_distance(self.inputV.row_vectors[token2] ,self.inputV.row_vectors[token1])
        if value > max
          max=value
          res_w = word2
        end
      end
      res_w
    end
    def similarity word1, word2
      v1=self.vocab[word1]
      v2=self.vocav[word2]
      v1.inner_product v2
    end
    #will take words from -context to +context wrt to the center word.
    def train_from_example sentence, context
      sentence_arr = sentence.split(" ")
      possible_center_tokens=[]
      sentence_arr.each do |word|
        token_id = self.vocab[word]
        raise Exception, "Word: "+word+" not in vocabulary." if token_id.nil?
        possible_center_tokens << self.vocab[word]
      end
      cost=0.0
      delta_out = WordRepresentation.zero(self.outputV.row_count, self.outputV.column_count)
      delta_in = WordRepresentation.zero(self.inputV.row_count, self.inputV.column_count)
      possible_center_tokens.each_with_index do |current_word,i|
        start_i=i-context
        end_i=i+context
        start_i = 0 if start_i<0
        end_i = possible_center_tokens.size-1 if i>possible_center_tokens.size-1
        c,d_in, d_out=skip_gram(current_word, possible_center_tokens[start_i..end_i])
        cost+=c
        delta_in+=d_in
        delta_out+=d_out
      end
      [cost, delta_out, delta_in]
    end

    private

    def skip_gram current_token, context_tokens
      cost=0.0
      context_size=context_tokens.size()
      delta_out = WordRepresentation.zero(self.outputV.row_count, self.outputV.column_count)
      delta_in = WordRepresentation.zero(self.inputV.row_count, self.inputV.column_count)
      predicted=self.inputV.row_vectors[current_token]
      context_tokens.each do |c_token|
        c, gIn, gOut = find_cost_and_gradient(predicted, c_token)
        cost+=c
        delta_in.add_m_to_row!(current_token, gIn)
        delta_out+=gOut
      end
      [cost, delta_in, delta_out]
    end

    def find_cost_and_gradient predicted, target_token
      probs = vector_softmax((predicted.covector*self.outputV.t).row_vectors[0])
      cost = -Math.log(probs[target_token])
      delta=probs
      new_value=delta[target_token]-1
      delta.send("[]=",target_token,new_value)
      gradOut=(predicted.covector.t*delta.covector).t
      gradIn=delta.covector*self.outputV
      [cost, gradIn, gradOut]
    end
  end
end
