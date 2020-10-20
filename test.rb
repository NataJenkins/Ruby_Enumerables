require_relative './enumerables.rb'

p '%%%%%%%%%%%%%%%%%%%%%%% MY EACH %%%%%%%%%%%%%%%%%%%%%'
puts 'my_each'
test_array1 = [11, 2, 3, 56]
test_array2 = %w[a b c d]
test_array1.my_each { |x| p x } == test_array1.each { |x| p x }
test_array2.my_each { |x| p x } == test_array2.each { |x| p x }

p '%%%%%%%%%%%%%%%%%%%%%%% MY SELECT %%%%%%%%%%%%%%%%%%%%%'
# p [1,2,3,4,5].my_select { |num|  num.even?  }   == p [1,2,3,4,5].select { |num|  num.even?  }

p '%%%%%%%%%%%%%%%%%%%%%%% MY ANY %%%%%%%%%%%%%%%%%%%%%'
p %w[ant bear cat].my_any? { |word| word.length >= 3 } == %w[ant bear cat].any? { |word| word.length >= 3 }
p %w[ant bear cat].my_any?(/d/) == %w[ant bear cat].any?(/d/)
p %w[ant bear cat].my_any?(/a/) == %w[ant bear cat].any?(/a/)
p [nil, true, 99].my_any?(Integer) == [nil, true, 99].any?(Integer)
p [nil, true, 99].my_any?(String) == [nil, true, 99].any?(String)
p [nil, true, 99].my_any?(Float) == [nil, true, 99].any?(Float)
p [nil, true, 99].my_any? == [nil, true, 99].any?
p [].my_any? == [].any?

p '%%%%%%%%%%%%%%%%%%%%%%% MY ALL %%%%%%%%%%%%%%%%%%%%%'
p %w[ant bear cat].my_all? { |word| word.length >= 3 }
p %w[ant bear cat].my_all? { |word| word.length >= 4 }
p %w[ant bear cat].my_all?(/t/)
p [1, 2i, 3.14].my_all?(Numeric)
p [nil, true, 99].my_all?
p [].all?

p '%%%%%%%%%%%%%%%%%%%%%%% MY ALL %%%%%%%%%%%%%%%%%%%%%'
p %w[ant bear cat].my_none? { |word| word.length == 5 } == %w[ant bear cat].none? { |word| word.length == 5 }
p %w[ant bear cat].my_none? { |word| word.length >= 4 } == %w[ant bear cat].none? { |word| word.length >= 4 }
p %w[ant bear cat].my_none?(/d/) == %w[ant bear cat].none?(/d/)
p [1, 3.14, 42].my_none?(Float) == [1, 3.14, 42].none?(Float)
p [].my_none? == [].none?
p [nil].my_none? == [nil].none?
p [nil, false].my_none? == [nil, false].none?
p [nil, false, true].my_none? == [nil, false, true].none?

p '%%%%%%%%%%%%%%%%%%%%%%% MY MAP %%%%%%%%%%%%%%%%%%%%%'
# p (1..4).my_map { |i| i*i } == p (1..4).map { |i| i*i }
p ((1..4).my_map { 'cat' }) == print((1..4).my_map { 'cat' })
p ([1, 2, 7, 4, 5].my_map { |x| x * x }) == print([1, 2, 7, 4, 5].map { |x| x * x })
p ((1..2).my_map { |x| x * x }) == print((1..2).map { |x| x * x })
