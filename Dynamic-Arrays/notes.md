# Static and Dynamic Arrays
##### Deconstructing Memory and Pointers

All of a program's data is stored in RAM (Random Access Memory), which consists of 64-bit cells. Every piece of data is represented as a string of bits. When we create an object in Ruby, we allocate memory. Our Ruby variables store pointers, which correspond to addresses in memory. So, for example, writing `my_array = Array.new(8)` allocates 8 cells worth of memory. 
