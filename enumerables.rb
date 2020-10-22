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
      each do |item|
        return false if yield(item) == false
      end
    elsif if arg.class == Regexp
            each do |item|
              return false if arg.match?(item) == false
            end
          elsif arg.class == Class
            each do |item|
              return false if item.is_a?(arg) == false
            end
          elsif arg.nil?
            each do |item|
              return false unless item
            end
          end
    end
    true
  end

  # my_any?
  def my_any?(arg = nil)
    if block_given? # con bloque sin argumento
      each do |item|
        return true if yield(item) == true
      end
      # con argumento
    elsif if arg.class == Regexp
            each do |item|
              return true if arg.match?(item) == true
            end
          elsif arg.class == Class
            each do |item|
              return true if item.is_a?(arg) == true
            end
          elsif arg.nil?
            each do |item|
              return true if item
            end
          end
    end
    false
  end

  # my_none?
  def my_none?(arg = nil)
    if block_given? # con bloque sin argumento
      each do |item|
        return false if yield(item) == true
      end
      # con argumento
    elsif if arg.class == Regexp
            each do |item|
              return false if arg.match?(item) == true
            end
          elsif arg.class == Class
            each do |item|
              return false if item.is_a?(arg) == true
            end
          elsif arg.nil?
            each do |item|
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

# rubocop:enable Metrics/ModuleLength,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
