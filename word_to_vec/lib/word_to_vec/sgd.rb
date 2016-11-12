module WordToVec
  module Sgd
    #Stochastic gradient descent.
    def self.perform model, c_sents, step_size, iterations, context, print_every
      iterations.times.each do |iteration_no|
        puts "Performing Iteration: #{iteration_no.to_s}" if iteration_no%print_every==0
        cost_t=0.0
        c_sents.shuffle.each do |sentence|
          cost, delta_out, delta_in = model.train_from_example sentence, context
          model.inputV-=step_size*(delta_in)
          model.outputV-=step_size*(delta_out)
          cost_t+=cost
        end
        puts "Cost:"+cost_t.to_s if iteration_no%print_every==0
      end
      model
    end
  end
end
