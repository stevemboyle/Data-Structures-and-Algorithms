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
