# Hash Maps

I built this implementation of a Hash Map in phases:

1. Building an Integer Set
2. Hashing
3. Building a Hash Set
4. Building a Linked List
5. Building a Hash Map
6. Building an LRU Cache

### Building an Integer Set

Sets, of course, store unique items in no particular order. In my initial construction (`01_integer_set.rb // MaxIntSet`), I built a set for only integers in a pre-existing, positive range. Using a `max` value, I built an array of that length, with the indices from 0 to the index one less than the length having values of either `true` or `false`, based on whether than positive integer was contained in the set.

The next step (`01_integer_set.rb // IntSet`) was to contend with an unpredictable range of integers by creating a fixed length array and then sorting the integers into sub-arrays based on the `integer % array.length`. This creates predictable sorting and handles negative numbers.

Next, I needed to ensure faster look-up times for arrays with large numbers of values. The solution here is to have arrays which can resize. In this implementation (`01_integer_set.rb / ResizingIntSet`), every time the number of integers in our set approaches to the number of buckets in our array, we double the size of our array.

### Building a Hash Set

The first step here (`03_hash_set.rb`) was to improve on `ResizingIntSet` by hashing every item before inserting it. Inserting it is still determined taking an integer (now the return value of the hashing) module the number of buckets. This now means that our new `HashSet`, based on `ResizingIntSet`, can handle any data type.

### Building a Linked List

My next goal was to build on the `Hash Set` by introducing key-value pairs to make it a `Hash Map`. As an intermediary step (`04_linked_list.rb`), I built a `Linked List` -- a data structure based on a series of links which all hold a `value` and a pointer to the `next` link or to nil. In this construction, so long as we have a pointer to the Head link, we can get to any link by traversing the links in order.

### Building a Hash Map

In this section (`05_hash_map.rb`), I built on the existing `HashSet` by changing all of our buckets to `Linked Lists`, which start out empty and grow by adding links to their tails.

By this point, I was able to build a functioning Hash Map which resizes dynamically. For each new value, we'd first (1) hash the key, (2) mod the hash of the key by the current number of buckets, (2) then add the key-value pair as a new link to the appropriate Linked List.

### Building an LRU CACHE

As we know, an LRU Cache is a cache of recently-used items, with LRU standing for 'Least Recently Used'. In this implementation (`06_lru_cache.rb`), we hold `max` many items and keep track of our most-recently used items, such that when we run the risk of exceeding `max`, we delete our least recently used item.

I built this by combining our Hash Map and our Linked List. 
