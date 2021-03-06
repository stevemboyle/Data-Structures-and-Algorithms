###############################################################################
# *****************************************************************************
# LINK
# *****************************************************************************
###############################################################################

class Link
  attr_accessor :key, :val, :next, :prev

  # ***************************************************************************
  # INITIALIZE
  # ***************************************************************************

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  # ***************************************************************************
  # TO STRING
  # ***************************************************************************

  def to_s
    "#{@key}: #{@val}"
  end
end

###############################################################################
# *****************************************************************************
# LINKED LIST
# *****************************************************************************
# Notes My next goal was to build on the `Hash Set` by introducing key-value
# pairs to make it a `Hash Map`. As an intermediary step (`04_linked_list.rb`),
# I built a `Linked List` -- a data structure based on a series of links which
# all hold a `value` and a pointer to the `next` link or to nil. In this
# construction, so long as we have a pointer to the Head link, we can get to
# any link by traversing the links in order. 
# *****************************************************************************
###############################################################################

class LinkedList
  include Enumerable

  # ***************************************************************************
  # INITIALIZE
  # ***************************************************************************

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  # ***************************************************************************
  # [](i)
  # ***************************************************************************

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  # ***************************************************************************
  # FIRST
  # ***************************************************************************

  def first
    empty? ? nil : @head.next
  end

  # ***************************************************************************
  # LAST
  # ***************************************************************************

  def last
    empty? ? nil : @tail.prev
  end

  # ***************************************************************************
  # EMPTY?
  # ***************************************************************************

  def empty?
    @head.next == @tail
  end

  # ***************************************************************************
  # GET
  # ***************************************************************************

  def get(key)
    each { |link| return link.val if link.key == key }
    nil
  end

  # ***************************************************************************
  # INCLUDE?
  # ***************************************************************************

  def include?(key)
    any? { |link| link.key == key }
  end

  # ***************************************************************************
  # INSERT
  # ***************************************************************************

  def insert(key, val)
    each { |link| return link.val = val if link.key == key }

    new_link = Link.new(key, val)

    @tail.prev.next = new_link
    new_link.prev = @tail.prev
    new_link.next = @tail
    @tail.prev = new_link

    new_link
  end

  # ***************************************************************************
  # REMOVE
  # ***************************************************************************

  def remove(key)
    each do |link|
      if link.key == key
        link.prev.next = link.next
        link.next.prev = link.prev
        link.next, link.prev = nil, nil
        return link.val
      end
    end

    nil
  end

  # ***************************************************************************
  # EACH
  # ***************************************************************************

  def each
    current_link = @head.next
    until current_link == @tail
      yield current_link
      current_link = current_link.next
    end
  end

  # ***************************************************************************
  # TO STRING
  # ***************************************************************************

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
