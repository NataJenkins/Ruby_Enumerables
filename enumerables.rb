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
    end

    #my_all?
    def my_all?
    end

    #my_any?
    def my_any?
    end

    #my_none?
    def my_none?
    end

    #my_count
    def my_count
    end

    #my_map
    def my_map(&block)
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
#MY MAP
#p (1..4).map { |i| i*i }      #=> [1, 4, 9, 16]
#p (1..4).collect { "cat"  }   #=> ["cat", "cat", "cat", "cat"]