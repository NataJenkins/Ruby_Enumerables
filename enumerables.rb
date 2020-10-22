# rubocop:disable Metrics/ModuleLength,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity

module Enumerable
  # my_each
  def my_each()
    return to_enum(:my_each) unless block_given?
    arr = to_a if self.class == Range
    arr = self if self.class == Array
    arr = to_a if self.class == Hash
    length.times do |n|
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
    length.times do |i|
      yield(arr[i], i)
    end
    self
  end

  # my_select
  def my_select()
    my_each do |elem|
      elem if yield(elem) == true
    end
  end

  # my_all?
  def my_all?(arg = nil)
    # con bloque sin argumento
    if block_given?
      my_each do |item|
        return false if yield(item) == false
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
  def my_map()
    result = []
    my_each do |n|
      yield(n)
    end
    result
  end

  # my_inject
  def my_inject(*args)
    start = 0
    if args[0].is_a? Numeric
      total = args[0]
      sym = args[1].to_s
    elsif (args[0].is_a? Symbol) || args[0].nil?
      total = Array(self)[0]
      sym = args[0].to_s
      start = 1
    end
    (start...Array(self).length).my_each do |i|
      total = if block_given?
                yield(total, Array(self)[i])
              else
                total.send(sym, Array(self)[i])
              end
    end
    total
  end
end


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
p %w[ant bear cat].my_all? { |word| word.length >= 3 } == %w[ant bear cat].all? { |word| word.length >= 3 } 
p %w[ant bear cat].my_all? { |word| word.length >= 4 } == %w[ant bear cat].all? { |word| word.length >= 4 } 
p %w[ant bear cat].my_all?(/t/) == %w[ant bear cat].all?(/t/)                        
p [1, 2i, 3.14].my_all?(Numeric) == [1, 2i, 3.14].all?(Numeric)                      
p [nil, true, 99].my_all? == [nil, true, 99].all?                           
p [].my_all? == [].all?                                           

p '%%%%%%%%%%%%%%%%%%%%%%% MY NONE %%%%%%%%%%%%%%%%%%%%%'
p %w{ant bear cat}.my_none? { |word| word.length == 5 } == %w{ant bear cat}.none? { |word| word.length == 5 }
p %w{ant bear cat}.my_none? { |word| word.length >= 4 } == %w{ant bear cat}.none? { |word| word.length >= 4 }
p %w{ant bear cat}.my_none?(/d/) == %w{ant bear cat}.none?(/d/)
p [1, 3.14, 42].my_none?(Float) == [1, 3.14, 42].none?(Float)
p [].my_none? == [].none?
p [nil].my_none? == [nil].none?
p [nil, false].my_none? ==  [nil, false].none?
p [nil, false, true].my_none? == [nil, false, true].none?

# rubocop:enable Metrics/ModuleLength,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
