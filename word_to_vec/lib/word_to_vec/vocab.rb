module WordToVec
  class Vocab < Hash
    def init_word_vectors vector_length
      inputV = WordRepresentation.initialize_2D_array self.keys.size, vector_length
      outputV = WordRepresentation.initialize_2D_array self.keys.size, vector_length
      [inputV, outputV]
    end
  end
end
