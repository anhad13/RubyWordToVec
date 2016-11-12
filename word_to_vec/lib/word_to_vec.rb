require 'word_to_vec/vocab.rb'
require 'word_to_vec/word_representation.rb'
require 'word_to_vec/sgd.rb'
require 'word_to_vec/extra_math.rb'
require 'word_to_vec/model.rb'
module WordToVec
  class << self
    #corpus=['<sentence 1>', 'sentence 2'....]
    def tokenize_vocab corpus
      token_id=0
      corpus_vocab = WordToVec::Vocab.new
      corpus.each do |sentence|
        sentence.split(" ").each{|word| next if corpus_vocab.has_key? word; corpus_vocab[word]=token_id; token_id+=1}
      end
      corpus_vocab
    end
    def build_from_corpus(corpus,dimensions,num_iterations=10,context=3,print_every=5, step_size=0.01)
      corpus=corpus.map(&:downcase)
      vocab = tokenize_vocab corpus
      inputV, outputV = vocab.init_word_vectors dimensions
      model= Model.new(inputV, outputV, vocab)
      Sgd.perform(model,corpus,step_size,num_iterations,context, print_every)
    end
  end
end
