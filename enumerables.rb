module Enumerable

  #my_each
    def my_each(&block)
      self.length().times do |n|
        yield(self[n])
      end
      return self
    end

    #my_each_with_index
    def my_each_with_index(&block)
        self.length().times do |i|
          yield(self[i],i)
        end
        return self
    end

    #my_select
    def my_select(&block)
        self.my_each do |elem|
            elem if yield(elem) == true
        end
    end

    #my_all?
    def my_all?(arg = nil)
      if block_given? # con bloque sin argumento
        self.each do |item|
          if yield(item) == false
            return false
          end
        end
      else # con argumento
        if arg.class == Regexp
          self.each do |item|
            return false if arg.match?(item) == false
          end
        elsif arg.class == Class
          self.each do |item|
            return false if item.is_a?(arg) == false
          end
        elsif arg == nil
          self.each do |item|
            return false if !item
          end
        end
      end
      true
    end
    
    #my_any?
    def my_any?(arg = nil)
      if block_given? # con bloque sin argumento
        self.each do |item|
          if yield(item) == true
            return true
          end
        end
      else # con argumento
        if arg.class == Regexp
          self.each do |item|
            return true if arg.match?(item) == true
          end
        elsif arg.class == Class
          self.each do |item|
            return true if item.is_a?(arg) == true
          end
        elsif arg == nil
          self.each do |item|
            return true if item
          end
        end
      end
      false
    end
  
    #my_none?
    def my_none?(arg = nil)
      if block_given? # con bloque sin argumento
        self.each do |item|
          if yield(item) == true
            return false
          end
        end
      else # con argumento
        if arg.class == Regexp
          self.each do |item|
            return false if arg.match?(item) == true
          end
        elsif arg.class == Class
          self.each do |item|
            return false if item.is_a?(arg) == true
          end
        elsif arg == nil
          self.each do |item|
            return false if item
          end
        end
      end
      true
    end
  end

    #my_count
    def my_count
    end

    #my_map
    def my_map(&block)
      result = Array.new
      self.my_each do |n|
        yield(n)
      end
      return result
    end

    #my_inject
    def my_inject
    end
end
