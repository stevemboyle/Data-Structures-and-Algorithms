###############################################################################
# *****************************************************************************
# MAX INTEGER SET
# *****************************************************************************
###############################################################################

class MaxIntSet

  # ***************************************************************************
  # INITIALIZE
  # ***************************************************************************
  # Here, we create an Array with indices from 0 to the Maximum Value.
  # All values in the Array are initialized to False.
  # ***************************************************************************

  def initialize(max)
    @store = Array.new(max, false)
  end

  # ***************************************************************************
  # INSERT
  # ***************************************************************************
  # First, we check that the number is not larger than the size of the array.
  # Next, we check if the value at that index is already set to true.
  # Then, we set the value at that index to True.
  # ***************************************************************************

  def insert(num)
    validate!(num)
    return false if @store[num]
    @store[num] = true
  end

  # ***************************************************************************
  # REMOVE
  # ***************************************************************************
  # First, we check that the number is not larger than the size of the array.
  # Next, we check if the value at that index is already False.
  # Then, we set the value of that index to False.
  # ***************************************************************************

  def remove(num)
    validate!(num)
    return nil unless include?(num)
    @store[num] = false
    num
  end

  # ***************************************************************************
  # INCLUDE
  # ***************************************************************************
  # First, we check that the number is not larger than the size of the array.
  # Then, we check whether our set includes the number.
  # We do this by checking whether the value at that index is True or False.
  # ***************************************************************************

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  # ***************************************************************************
  # IS VALID?
  # ***************************************************************************
  # We check that our number is within the scope of the array.
  # ***************************************************************************

  def is_valid?(num)
    num.between?(0, @store.length - 1)
  end

  # ***************************************************************************
  # VALIDATE
  # ***************************************************************************
  # We raise an error if our number is not within the scope of the array.
  # ***************************************************************************

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end

###############################################################################
# *****************************************************************************
# INTEGER SET
# *****************************************************************************
###############################################################################

class IntSet

  # ***************************************************************************
  # INITIALIZE
  # ***************************************************************************
  # We create a new Array with a specified number of buckets.
  # ***************************************************************************

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  # ***************************************************************************
  # INSERT
  # ***************************************************************************
  # First, we check whether that number is already included in our Set.
  # Then, we push the number into the bucket at its corresponding index.
  # ***************************************************************************

  def insert(num)
    return false if include?(num)
    self[num] << num
    num
  end

  # ***************************************************************************
  # REMOVE
  # ***************************************************************************
  # We delete the number from the bucket at its corresponding index.
  # ***************************************************************************

  def remove(num)
    self[num].delete(num)
  end

  # ***************************************************************************
  # INCLUDE
  # ***************************************************************************
  # We check whether number's corresponding index's bucket includes the number.
  # ***************************************************************************

  def include?(num)
    self[num].include?(num)
  end

  private

  # ***************************************************************************
  # GETTER
  # ***************************************************************************
  # The index for a number is found by that number modulo the number of buckets.
  # The number of buckets is, of course, a number that changes.
  # ***************************************************************************

  def [](num)
    @store[num % num_buckets]
  end

  # ***************************************************************************
  # NUMBER OF BUCKETS
  # ***************************************************************************
  # The number of buckets is equal to the Set's length.
  # ***************************************************************************

  def num_buckets
    @store.length
  end
end

###############################################################################
# *****************************************************************************
# RESIZING INTEGER SET
# *****************************************************************************
###############################################################################

class ResizingIntSet
  attr_reader :count

  # ***************************************************************************
  # INITIALIZE
  # ***************************************************************************
  # We create an Array where each of the buckets is an empty Array.
  # Our count begins at zero.
  # ***************************************************************************

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  # ***************************************************************************
  # INSERT
  # ***************************************************************************
  # Return false if the Number is already in our Set.
  # The Number's Index is the Number modulo the Number of Buckets.
  # Insert the Number into the Array at its Index.
  # Increment the Count by 1.
  # If the Count exceeds the Number of Buckets, resize the Array.
  # We resize the Array by doubling its Number of Buckets and resorting.
  # ***************************************************************************

  def insert(num)
    return false if include?(num)
    self[num] << num
    @count += 1
    resize! if num_buckets < @count

    num
  end

  # ***************************************************************************
  # REMOVE
  # ***************************************************************************

  def remove(num)
    self[num].delete(num)
  end

  # ***************************************************************************
  # INCLUDE
  # ***************************************************************************

  def include?(num)
    self[num].include?(num)
  end

  private

  # ***************************************************************************
  # NUMBER OF BUCKETS
  # ***************************************************************************

  def num_buckets
    @store.length
  end

  # ***************************************************************************
  # RESIZE
  # ***************************************************************************

  def resize!
    old_store = @store
    @count = 0
    @store = Array.new(num_buckets * 2) { Array.new }

    old_store.flatten.each { |num| insert(num) }
  end

  # ***************************************************************************
  # GETTER
  # ***************************************************************************

  def [](num)
    @store[num % num_buckets]
  end
end
