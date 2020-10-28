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
    if block_given?
      my_each do |item| 
        return false if yield(item) == false 
      end
      return true
    elsif arg.nil?
      my_each do |item| 
        return false if item.nil? || item == false 
      end
    elsif !arg.nil? && (arg.is_a? Class)
      my_each do |item| 
        return false unless [item.class, item.class.superclass].include?(arg) 
      end
    elsif !arg.nil? && arg.class == Regexp
      my_each do |item|
         return false unless arg.match(item) 
      end
    else
      my_each do |item| 
        return false if item != arg 
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

  def my_inject(initial = nil, sym = nil)
    if (!initial.nil? && sym.nil?) && (initial.is_a?(Symbol) || initial.is_a?(String))
      sym = initial
      initial = nil
    end
    if !block_given? && !sym.nil?
      to_a.my_each { |item| initial = initial.nil? ? item : initial.send(sym, item) }
    else
      to_a.my_each { |item| initial = initial.nil? ? item : yield(initial, item) }
    end
    initial
  end
end



def multiply_els(arr)
  arr.my_inject(1, :*)
end

p ["dog", "door", "rod", "blade"].my_inject{ |memo, word| memo.length > word.length ? memo : word }