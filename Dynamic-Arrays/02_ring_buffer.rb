require_relative "01_static_array"

###############################################################################
# *****************************************************************************
# RING BUFFER
# *****************************************************************************
###############################################################################

class RingBuffer
  attr_reader :length

  # ***************************************************************************
  # INITALIZE
  # ***************************************************************************
  # Create a Static Array of length 8, where the Value at each Index is nil.
  # Set the Capacity at 8.
  # Set the Start Index at 0.
  # Set the initial Length at 0.
  # ***************************************************************************

  def initialize
    self.store, self.capacity = StaticArray.new(8), 8
    self.start_idx, self.length = 0, 0
  end

  # ***************************************************************************
  # GET
  # O(1) Time Complexity for Look-Up
  # ***************************************************************************
  # First, check whether the Index given is out of bounds.
  # Then, fetch the Value at the Start Index + the Index, modulo the Capacity
  # ***************************************************************************

  def [](index)
    check_index(index)
    store[(start_idx + index) % capacity]
  end

  # ***************************************************************************
  # GET
  # O(1) Time Complexity for Setting a Value
  # ***************************************************************************
  # First, check whether the Index given is out of bounds.
  # Then, fetch the Value at the Start Index + the Index, modulo the Capacity
  # ***************************************************************************

  def []=(index, val)
    check_index(index)
    store[(start_idx + index) % capacity] = val
  end

  # ***************************************************************************
  # POP
  # O(1) Time Complexity
  # ***************************************************************************
  # If the Array has no values to pop, raise an error.
  # Our return Value is the final index in the Array, as determined by Length.
  # Set the Value at that former final index to nil.
  # Decrement Length by 1.
  # ***************************************************************************

  def pop
    raise "index out of bounds" if (length == 0)

    return_value = self[length - 1]
    self[length - 1] = nil
    self.length -= 1

    return_value
  end

  # ***************************************************************************
  # PUSH
  # O(1) Time Complexity (Ammortized)
  # ***************************************************************************
  # If our Length is at Capacity, we must Resize before inserting a new Value.
  # Increment length by 1.
  # Then, insert the Value at our new final Index, as determined by Length.
  # Return nil.
  # ***************************************************************************

  def push(new_value)
    resize! if (length == capacity)

    self.length += 1
    self[length - 1] = new_value

    nil
  end

  # ***************************************************************************
  # SHIFT
  # O(1) Time Complexity
  # ***************************************************************************
  # If the Array has no values to shift, raise an error.
  # Our return Value is the Value of the first index in the Array.
  # Set the Value at that former first index to nil.
  # Now, we must adjust the Start Index.
  # To do this, increment the Start Index by 1, then modulo the Capacity.
  # Decrement Length by 1.
  # Return the return Value.
  # ***************************************************************************

  def shift
    raise "index out of bounds" if (length == 0)

    return_value = self[0]
    self[0] = nil
    self.start_idx = (start_idx + 1) % capacity
    self.length -= 1

    return_value
  end

  # ***************************************************************************
  # UNSHIFT
  # O(1) Time Complexity (Ammortized)
  # ***************************************************************************
  # If our Length is at Capacity, we must Resize before inserting a new Value.
  # Set our new Start Index to our former Start Index minus 1, module Capacity
  # Increment length by 1.
  # Then, insert the Value at our zero index.
  # ***************************************************************************

  def unshift(new_value)
    resize! if (length == capacity)

    self.start_idx = (start_idx - 1) % capacity
    self.length += 1
    self[0] = new_value
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  # ***************************************************************************
  # CHECK INDEX
  # ***************************************************************************
  # Check whether the index is out of bounds.
  # ***************************************************************************


  def check_index(index)
    unless (index >= 0) && (index < length)
      raise "index out of bounds"
    end
  end

  # ***************************************************************************
  # RESIZE
  # ***************************************************************************
  # Double our Capacity.
  # Create a new Static Array with our new Capacity.
  # Reassign the values in our old Array to our new Array.
  # Set our Capacity to our new Capacity.
  # Set our Store to our new Store.
  # Set our Start Index back at 0.
  # ***************************************************************************

  def resize!
    new_capacity = capacity * 2
    new_store = StaticArray.new(new_capacity)
    length.times { |i| new_store[i] = self[i] }

    self.capacity = new_capacity
    self.store = new_store
    self.start_idx = 0
  end
end
