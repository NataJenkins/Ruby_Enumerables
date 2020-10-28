module Enumerable
  # my_each
  def my_each()
    return to_enum(:my_each) unless block_given?

    arr = to_a if self.class == Range
    arr = self if self.class == Array
    arr = to_a if self.class == Hash
    Array(self).length.times do |n|
      yield(arr[n])
    end
    self
  end

  # my_each_with_index
  def my_each_with_index()
    return to_enum(:my_each) unless block_given?

    arr = to_a if self.class == Range
    arr = self if self.class == Array
    arr = to_a if self.class == Hash
    Array(self).length.times do |i|
      yield(arr[i], i)
    end
    self
  end

  # my_select
  def my_select()
    result = []
    return to_enum unless block_given?

    Array(self).my_each do |elem|
      next unless yield(elem)

      result.push(elem)
    end
    result
  end

  # my_all?
  def my_all?(arg = nil)
    # con bloque sin argumento
    if block_given?
      my_each do |item|
        return false if yield(item) == true
      end
    elsif if arg.class == Regexp
            my_each do |item|
              return false if arg.match?(item) == false
            end
          elsif arg.class == Class
            my_each do |item|
              return false if item.is_a?(arg) == false
            end
          elsif arg.nil?
            my_each do |item|
              return false unless item
            end
          else
            my_each do |item|
              return false if item != arg
            end
          end
    end
    true
  end

  # my_any?
  def my_any?(arg = nil)
    if block_given? # con bloque sin argumento
      my_each do |item|
        return true if yield(item) == true
      end
      # con argumento
    elsif if arg.class == Regexp
            my_each do |item|
              return true if arg.match?(item) == true
            end
          elsif arg.class == Class
            my_each do |item|
              return true if item.is_a?(arg) == true
            end
          elsif arg.nil?
            my_each do |item|
              return true if item
            end
          else
            my_each do |item|
              return true if item == arg
            end
          end
    end
    false
  end

  # my_none?
  def my_none?(arg = nil)
    if block_given? # con bloque sin argumento
      my_each do |item|
        return false if yield(item) == true
      end
      # con argumento
    elsif if arg.class == Regexp
            my_each do |item|
              return false if arg.match?(item) == true
            end
          elsif arg.class == Class
            my_each do |item|
              return false if item.is_a?(arg) == true
            end
          elsif arg.nil?
            my_each do |item|
              return false if item
            end
          else
            my_each do |item|
              return false if item == arg
            end
          end
    end
    true
  end

  def my_count(argument = nil)
    count = 0
    Array(self).my_each do |item|
      if !block_given?
        return Array(self).length if argument.nil?
        next if item != argument

        count += 1
      elsif yield(item) == true
        count += 1
      end
    end
    count
  end

  # my_map

  def my_map(argument = nil)
    arr = []

    if argument.class == Proc
      Array(self).my_each do |item|
        arr.push(argument.call(item))
      end
      return arr
    end

    return to_enum unless block_given?

    Array(self).my_each do |item|
      arr.push(yield(item))
    end
    arr
  end

  # my_inject
#   def my_inject(*args)
#     raise('LocalJumpError.new NO BLOCK OR ARGUMENT GIVEN!') if !block_given? && args.empty?

#     start = 0
#     if args[0].is_a? Numeric
#       total = args[0]
#       sym = args[1].to_s
#     elsif (args[0].is_a? Symbol) || args[0].nil?
#       total = Array(self)[0]
#       sym = args[0].to_s
#       start = 1
#     end
#     (start...Array(self).length).my_each do |i|
#       total = if block_given?
#                 yield(total, Array(self)[i])
#               else
#                 total.send(sym, Array(self)[i])
#               end
#     end
#     total
#   end
# end



def my_inject(args = nil, sym = nil)
  if (!args.nil? && sym.nil?) && (args.is_a?(Symbol) || args.is_a?(String))
    sym = args
    args = nil
  end
  if !block_given? && !sym.nil?
    to_a.my_each do |index| 
      args = args.nil? ? index : args.send(sym, index) 
    end
  else
    to_a.my_each do |item| 
      args = args.nil? ? index : yield(args, index) 
    end
  end
  args
end
end

def multiply_els(arr)
  arr.my_inject(1, :*)
end

# p (0..5).my_none? == (0..5).none?
# p (0..5).my_any? == (0..5).any?
# p (0..5).my_all? == (0..5).all?

# p (1..4).my_map { |i| i*i }
# p (1..4).map { |i| i*i }
# p (1..4).my_map { "cat"  }
# p (1..4).map { "cat"  }

# p [1,2,3,4,5].my_inject(:*) == [1,2,3,4,5].inject(:*)
# p [1,2,3,4,5].my_inject(2, :*) ==[1,2,3,4,5].inject(2, :*)
# p (5..10).my_inject { |sum, n| sum + n } == (5..10).inject { |sum, n| sum + n }
# p (1..5).my_inject(:*) == (1..5).inject(:*)
# p (1..5).my_inject(2, :*) == (1..5).inject(2, :*)
# p [5,6,7,8,9,10].my_inject(1) { |product, n| product * n } == [5,6,7,8,9,10].inject(1) { |product, n| product * n }
# p (5..10).my_inject(1) { |product, n| product * n } == (5..10).inject(1) { |product, n| product * n }

# words = ['Purple', 'PinkFloyd', 'Microverse']
# p words.my_none? 'cat'
# p words.none? 'cat'

# my_proc = proc { |w| w * 2 }
# words = %w[Purple PinkFloyd Microverse]
# p words.map(&my_proc)
# p words.my_map(my_proc)

# p 'Test #my_all method'
# p (%w[ant bear cat].my_all? { |word| word.length >= 3 }) == (%w[ant bear cat].all? { |word| word.length >= 3 })
# p (%w[ant bear cat].my_all? { |word| word.length >= 4 }) == (%w[ant bear cat].all? { |word| word.length >= 4 })
# p %w[ant bear cat].my_all?(/t/) == %w[ant bear cat].all?(/t/)
# p [1, 2i, 3.14].my_all?(Numeric) == [1, 2i, 3.14].all?(Numeric)
# p [nil, true, 99].my_all? == [nil, true, 99].all?
# p [].my_all? ==[].all?
# p [1, 2].my_all?(1) == [1, 2].all?(1)
# p [1, 1].my_all?(1) == [1, 1].all?(1)
# p %w[a b].my_all?('b') == %w[a b].all?('b')
# p %w[a a].my_all?('a') == %w[a a].all?('a')

puts multiply_els([2, 4, 5])
