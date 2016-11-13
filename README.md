# RubyWordToVec: A ruby gem implementation based on Google's Word2Vec.

## Steps to build & install the gem:
* Run : 'gem build word_to_vec.gemspec'
* Install : 'gem install ./word_to_vec-1.0.0.gem'

## Using the gem:
```ruby
require 'word_to_vec'
corpus=['<sentence 1>', '<sentence 2>']
Eg: corpus=['this is great', 'I am great']
model=WordToVec.build_from_corpus(
  corpus,
  <No of dimensions of final vector>,
  <No of iterations(default=10)>,
  <Size of context(default=3)>,
  <n, where print every nth iteration(default=5)>,
  <step_size of stochastic gradient descent(default=)>
  )
```

Like so,  WordToVec.build_from_corpus corpus,dimensions, num_iterations=10,context=3 ,print_every=5, step_size=0.01
To get input vector for word:
```ruby 
model.print_inputV(<word>)
```
To get output vector for word:
```ruby
model.print_outputV(<word>)
```
To get word closest to representation:
```ruby
model.closest(<word>)
```









