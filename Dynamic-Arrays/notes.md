# Static and Dynamic Arrays
##### Deconstructing Memory and Pointers

All of a program's data is stored in RAM (Random Access Memory), which consists of 64-bit cells. Every piece of data is represented as a string of bits. When we create an object in Ruby, we allocate memory. Our Ruby variables store pointers, which correspond to addresses in memory. So, for example, writing `my_array = Array.new(8)` allocates 8 cells worth of memory.

Data is stored contiguously, so if want to set the value of a static Array at a particular index, we issue a `STORE` instruction to the cell at `my_array + (index * 8)`. This is a based on simple numerical calculations, so it's memory access is `O(1)`. But, what if we want an array of flexible size?

We can use a ring buffer to create dynamic arrays. A dynamic array keeps track of its store, the total storage space, and its current number of items. The innovation comes from keeping a buffer to the right of the store's space. If there is room for a new value, we insert just as before, with `O(1)` time complexity.

If, on the other hand, we hit up against our buffer, then we have to reallocate a new store by copying over all of our existing references, which takes `O(n)` time. However, if we double our store size with every resize, we can get `push` to an amortized time complexity of only `O(1)`.
