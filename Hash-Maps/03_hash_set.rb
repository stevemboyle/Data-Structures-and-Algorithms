require_relative 'p02_hashing'

###############################################################################
# *****************************************************************************
# HASH SET
# *****************************************************************************
# Notes The first step here (`03_hash_set.rb`) was to improve on
# `ResizingIntSet` by hashing every item before inserting it. Inserting it is
# still determined taking an integer (now the return value of the hashing)
# modulo the number of buckets. This now means that our new `HashSet`, based on
# `ResizingIntSet`, can handle any data type.
# *****************************************************************************
###############################################################################

class HashSet
  attr_reader :count

  # ***************************************************************************
  # INITIALIZE
  # Create a new Array with 8 Buckets.
  # Set the count to 0.
  # ***************************************************************************

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  # ***************************************************************************
  # INSERT
  # ***************************************************************************

  def insert(key)
    return false if include?(key)
    self[key.hash] << key
    @count += 1
    resize! if num_buckets < @count

    key
  end

  # ***************************************************************************
  # INCLUDE
  # ***************************************************************************

  def include?(key)
    self[key.hash].include?(key)
  end

  # ***************************************************************************
  # REMOVE
  # ***************************************************************************

  def remove(key)
    return nil unless include?(key)
    self[key.hash].delete(key)
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

    old_store.flatten.each { |key| insert(key) }
  end

  # ***************************************************************************
  # GETTER
  # ***************************************************************************

  def [](num)
    @store[num % num_buckets]
  end
end
