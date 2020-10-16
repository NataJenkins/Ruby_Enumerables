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
    def my_all?(&block)
    end
    

    #my_any?
    def my_any?(args = nil)
      array = to_a
      array(self).my_each do |elem|
        if !block_given?
        

        end
      end



      array = to_a
      if args == nil
        x = 0
        until x == array.size
          if block_given? && (yield array[x])
            return true
          elsif !block_given? && (array[x])
            return true
          end
          x += 1
        end
      elsif args != nil?
        y = 0
        until y == array.size
          if array[y].is_a?(Float) && args == Float
            return true
          elsif array[y].is_a?(Integer) && args == Integer
            return true
          elsif array[y].is_a?(Numeric) && args == Numeric
            return true
          elsif (args.is_a?(Numeric) || args.is_a?(String)) && array[y] == args
            return true
          end
          y += 1
        end
      end
      if !args.nil? && args.is_a?(Regexp)
        i = 0
        until i == size
          return true if array[i].match?(args)
          i += 1
        end
      end
      false
    end
#      self.my_each do |elem|
#        return true if yield(elem) 
#      end
#      false
  

    #my_none?
    def my_none?
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




#EXAMPLES

#MY EACH
#puts 'my_each'
#test_array1 = [11, 2, 3, 56]
#test_array2 = %w(a b c d)
#test_array1.my_each { |x| p x }
#test_array2.my_each { |x| p x }
#puts "- - - -"

#MY SELECT
#p (1..10).find_all { |i|  i % 3 == 0 }   #=> [3, 6, 9]
#p [1,2,3,4,5].select { |num|  num.even?  }   #=> [2, 4]
#p [:foo, :bar].filter { |x| x == :foo }   #=> [:foo]

#MY ANY?
p %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
p %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
p %w[ant bear cat].my_any?(/d/)                        #=> false
p [nil, true, 99].my_any?(Integer)                     #=> true
p [nil, true, 99].my_any?                              #=> true
p [].my_any?                                           #=> false

#MY MAP
#p (1..4).map { |i| i*i }      #=> [1, 4, 9, 16]
#p (1..4).collect { "cat"  }   #=> ["cat", "cat", "cat", "cat"]