require_relative 'p02_hashing'
require_relative 'p04_linked_list'

###############################################################################
# *****************************************************************************
# HASH MAP
# *****************************************************************************
# Notes: In this section (`05_hash_map.rb`), I built on the existing `HashSet`
# by changing all of our buckets to `Linked Lists`, which start out empty and
# grow by adding links to their tails. By this point, I was able to build a
# functioning Hash Map which resizes dynamically. For each new value, we'd
# first (1) hash the key, (2) mod the hash of the key by the current number of
# buckets, (2) then add the key-value pair as a new link to the appropriate
# Linked List.
# *****************************************************************************
###############################################################################

class HashMap
  include Enumerable

  attr_reader :count

  # ***************************************************************************
  # INITIALIZE
  # We create a new Array where each bucket is a Linked List.
  # Our count begins at zero.
  # ***************************************************************************

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  # ***************************************************************************
  # INCLUDE?
  # ***************************************************************************

  def include?(key)
    bucket(key).include?(key)
  end

  # ***************************************************************************
  # SET
  # ***************************************************************************

  def set(key, val)
    delete(key) if include?(key)
    resize! if @count >= num_buckets

    @count += 1
    bucket(key).insert(key, val)
  end

  # ***************************************************************************
  # GET
  # ***************************************************************************

  def get(key)
    bucket(key).get(key)
  end

  # ***************************************************************************
  # DELETE
  # ***************************************************************************

  def delete(key)
    removal = bucket(key).remove(key)
    @count -= 1 if removal
    removal
  end

  # ***************************************************************************
  # EACH
  # ***************************************************************************

  def each
    @store.each do |bucket|
      bucket.each { |link| yield [link.key, link.val] }
    end
  end

  # ***************************************************************************
  # TO STRING
  # ***************************************************************************

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k} => #{v}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :inspect, :to_s
  alias_method :[], :get
  alias_method :[]=, :set

  private

  # ***************************************************************************
  # NUMBER OF BUCKETS
  # The number of buckets is the length of the current Array.
  # ***************************************************************************

  def num_buckets
    @store.length
  end

  # ***************************************************************************
  # RESIZE
  # We double the size of our Array.
  # Each bucket in the Array is a Linked List.
  # We resort our existing items into our new Array.
  # ***************************************************************************

  def resize!
    old_store = @store
    @store = Array.new(num_buckets * 2) { LinkedList.new }
    @count = 0

    old_store.each do |bucket|
      bucket.each { |link| set(link.key, link.val) }
    end
  end

  # ***************************************************************************
  # BUCKET
  # ***************************************************************************

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
