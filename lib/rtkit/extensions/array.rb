class Array

  # Rearranges the array (self) so that its elements appear in exactly
  # the same sequence as another array (the argument).
  # If the two arrays do not contain the same set of elements, an error is raised.
  #
  # === Examples
  #
  #    a = [5, 2, 10, 1]
  #    b = [10, 2, 1, 5]
  #    b.assimilate!(a)
  #    b
  #    => [5, 2, 10, 1]
  #
  # NB! Not in use atm!
  #
  def assimilate!(other)
    if self.length != other.length
      raise ArgumentError, "Arrays 'self' and 'other' are of unequal length. Unable to compare."
    else
      # Validate equality:
      self.each_index do |i|
        index = other.index(self[i])
        if index
          self[i] = other[index]
        else
          raise "An element (index #{i}) in self was not found in the other array. Unable to assimilate."
        end
      end
    end
    return self
  end

  # Compares an array (self) with a target array to determine an array of indices which can be
  # used to extract the elements of self in order to create an array which shares the exact
  # order of elements as the target array.
  # Naturally, for this comparison to make sense, the target array and self must
  # contain the same set of elements.
  # Raises an error if self and other are not of equal length.
  #
  # === Restrictions
  #
  # * Behaviour may be incorrect if the array contains multiple identical objects.
  #
  # === Examples
  #
  #    a = ['hi', 2, dcm]
  #    b = [2, dcm, 'hi']
  #    order = b.compare_with(a)
  #    => [2, 0, 1]
  #
  def compare_with(other)
    raise ArgumentError, "Arrays 'self' and 'other' are of unequal length. Unable to compare." if self.length != other.length
    if self.length > 0
      order = Array.new
      other.each do |item|
        index = self.index(item)
        if index
          order << index
        else
          raise "An element (#{item}) from the other array was not found in self. Unable to complete comparison."
        end
      end
    end
    return order
  end

  # Returns the most common value in the array.
  #
  def most_common_value
    self.group_by do |e|
      e
    end.values.max_by(&:size).first
  end

  # Returns an array where the elements of the original array are extracted
  # according to the indices given in the argument array.
  #
  # === Examples
  #
  #    a = [5, 2, 10, 1]
  #    i = a.sort_order
  #    a.sort_by_order(i)
  #    => [1, 2, 5, 10]
  #
  #
  def sort_by_order(order=[])
    if self.length != order.length
      return nil
    else
      return self.values_at(*order)
    end
  end

  # Rearranges an array (self) so that it's original elements in the
  # order specified by the indices given in the argument array.
  #
  # === Examples
  #
  #    a = [5, 2, 10, 1]
  #    a.sort_by_order!([3, 1, 0, 2])
  #    a
  #    => [1, 2, 5, 10]
  #
  def sort_by_order!(order=[])
    raise ArgumentError, "Invalid argument 'order'. Expected length equal to self.length (#{self.length}), got #{order.length}." if self.length != order.length
    # It only makes sense to sort if length is 2 or more:
    if self.length > 1
      copy = self.dup
      self.each_index do |i|
        self[i] = copy[order[i]]
      end
    end
    return self
  end

  # Returns an ordered array of indices, where each element contains the index in the original array
  # which needs to be extracted to produce a sorted array.
  # This method is useful if you wish to sort multiple arrays depending on the sequence of elements in a specific array.
  #
  # === Examples
  #
  #    a = [5, 2, 10, 1]
  #    a.sort_order
  #    => [3, 1, 0, 2]
  #
  def sort_order
    d=[]
    self.each_with_index{|x,i| d[i]=[x,i]}
    if block_given?
      return d.sort {|x,y| yield x[0],y[0]}.collect{|x| x[1]}
    else
      return d.sort.collect{|x| x[1]}
    end
  end

end