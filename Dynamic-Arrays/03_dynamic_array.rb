require_relative "01_static_array"

###############################################################################
# *****************************************************************************
# DYNAMIC ARRAY
# *****************************************************************************
###############################################################################

class DynamicArray
  attr_reader :length

  # ***************************************************************************
  # INITIALIZE
  # ***************************************************************************
  # Set our Store to a Static Array with 8 Buckets.
  # Set our Capacity to 8.
  # Set our initial Length to 0.
  # ***************************************************************************

  def initialize
    self.store, self.capacity, self.length = StaticArray.new(8), 8, 0
  end

  # ***************************************************************************
  # GET
  # O(1) Time Complexity
  # ***************************************************************************
  # First, check whether our requested Index is out of bounds.
  # Fetch the value from the Store at that Index.
  # ***************************************************************************

  def [](index)
    check_index(index)
    store[index]
  end

  # ***************************************************************************
  # SET
  # O(1) Time Complexity
  # ***************************************************************************
  # First, check whether our requested Index is out of bounds.
  # Set the value at that Index.
  # ***************************************************************************

  def []=(index, value)
    check_index(index)
    store[index] = value
  end

  # ***************************************************************************
  # POP
  # O(1) Time Complexity
  # ***************************************************************************
  # Raise an error if there are no values to pop.
  # 
  # ***************************************************************************

  def pop
    raise "index out of bounds" unless (length > 0)

    val, self[length - 1] = self[length - 1], nil
    self.length -= 1

    val
  end

  # O(1) ammortized; O(n) worst case.
  def push(val)
    resize! if length == capacity

    self.length += 1
    self[length - 1] = val

    nil
  end

  # O(n)
  def shift
    raise "index out of bounds" if (length == 0)

    val = self[0]
    (1...length).each { |i| self[i - 1] = self[i] }
    self.length -= 1

    val
  end

  # O(n)
  def unshift(val)
    resize! if length == capacity

    self.length += 1
    (length - 2).downto(0).each { |i| self[i + 1] = self[i] }
    self[0] = val

    nil
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    unless (index >= 0) && (index < length)
      raise "index out of bounds"
    end
  end

  # O(n)
  def resize!
    new_capacity = capacity * 2
    new_store = StaticArray.new(new_capacity)
    length.times { |i| new_store[i] = self[i] }

    self.capacity = new_capacity
    self.store = new_store
  end
end
