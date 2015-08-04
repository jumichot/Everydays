# NOTE keyword list are note enumerable, so no Enum for them !
Enum.map([1, 2, 3], fn x -> x * 2 end) # [2, 4, 6]
Enum.map(%{1 => 2, 3 => 4}, fn {k, v} -> k * v end) # [2, 12]

#########################################################################
# ENUMERABLES
#########################################################################
# NOTE Pipe operator
1..100_000 |> Enum.map(&(&1 * 3)) |> Enum.filter(odd?) |> Enum.sum

# ruby equivalent :
# (0..100000).map{|i| i*3 }.select{|i| i.odd? }.inject(&:+)

# withouth the pipe :
Enum.sum(Enum.filter(Enum.map(1..100_000, &(&1 * 3)), odd?))

#########################################################################
# ENUMERABLES elixirsips
#########################################################################
#### all?
Enum.all?([1,2,3], fn(x) -> rem(x, 2) == 0 end) # false, because of 1 and 3
Enum.all?([2,6], fn(x) -> rem(x, 2) == 0 end) # true
Enum.all?([2,6], fn(x) -> x > 0 end) # true

### any?
Enum.any?([1,2,3], fn(x) -> rem(x, 2) == 0 end) # true (2)
Enum.any?([1,5,3], fn(x) -> rem(x, 2) == 0 end) # false
Enum.any?([1,5,3], fn(x) -> x < 0 end) # false

### at, 0 based index
Enum.at([1,2,3], 1) # 2
Enum.at([1,2,3], 4) # nil, don't raise exception for index > size of the list

### chunk/2 (you got not all element...)
Enum.chunk([1,2,3,4], 2) # [[1, 2], [3, 4]]
Enum.chunk([1,2,3,4], 4) # [[1, 2, 3, 4]]
Enum.chunk([1,2,3,4], 42) # []
### chunk/3
Enum.chunk([1,2,3,4,5], 3, 2) # [[1, 2, 3], [3, 4, 5]]
### chunk/4
Enum.chunk([1,2,3,4,5], 3, 3, [1]) # [[1, 2, 3], [4, 5, 1]]
Enum.chunk([1, 2, 3, 4, 5, 6], 4,4)  # [[1, 2, 3, 4]]
Enum.chunk([1, 2, 3, 4, 5, 6], 4,4, [1]) # [[1, 2, 3, 4], [5, 6, 1]]
Enum.chunk([1, 2, 3, 4, 5, 6], 4,4, [nil]) # [[1, 2, 3, 4], [5, 6, nil]]
### chunk_by
Enum.chunk_by([1, 2, 2, 3, 4, 4, 6, 7, 7], fn(x) -> rem(x, 2) == 1 end)

### concat
Enum.concat([[1],[2,3], [4]]) #[1, 2, 3, 4]
Enum.concat(1..2, 3..3) #[1, 2, 3]

## count/1
Enum.count([2,3]) # 22
## count/2
Enum.count([:a, 1,2], fn(x) -> is_integer(x) end) # 2

### drop
Enum.drop([1,3,4,3,5,6], 3) #[3, 5, 6]
### drop_while
Enum.drop_while([1,3,4,3,5,6], fn(x)-> rem(x, 2) != 0 end) # [4, 3, 5, 6]
### each
Enum.each([1,2,3,4,5,6,7], fn(x) -> IO.puts("#{x}") end) # like each in ruby
### empty?
Enum.empty?([]) # true
Enum.empty?([1]) # false
### fetch
Enum.fetch([1,2,34,5],2) # {:ok, 34}
Enum.fetch([1,2,34,5],20) # :error
Enum.fetch!([1,2,34,5],2) # 34
Enum.fetch!([1,2,34,5],20) # ** (Enum.OutOfBoundsError) out of bounds error
### filter
Enum.filter([1,2,3,4,5,6], fn(x) -> rem(x,2) == 0 end) # [2, 4, 6]
### filter_map
Enum.filter_map([1,2,3,4,5,6], fn(x) -> rem(x,2) == 0 end, fn(x) -> "foo#{x}" end) # ["foo2", "foo4", "foo6"]

### find
Enum.find([-1,0,1], fn(x) -> x > 0 end) # 1
Enum.find([-1,0,1], fn(x) -> x >= 0 end) # 0
Enum.find([-1,0,1], fn(x) -> x > 2 end) # nil
Enum.find([-1,0,1], :foo, fn(x) -> x > 2 end) # :foo : you can add default if not found, like fetch in ruby

### first
List.first([-1,0,1]) # -1, Enum.first deprecated, use Enum.at

### find_index
Enum.find_index([1,2,3,4,5,6], fn(x) -> x > 3 end) # 3
Enum.find_index([1,2,3,4,5,6], fn(x) -> x > 30 end) # nil

### find_value
Enum.find_value([-1,0,1], fn(x) -> x >= 0 end) #  true
iex(5)> Enum.find_value([-1,0,1], fn(x) -> x >= 10 end) # nil
#########################################################################
# STREAMS
#########################################################################
# NOTE use streams when big collection and don't want to generate
# intermediate list in memory
# Lazy operations, for larges ressources
# evaluated only when it is passed to Enum
odd? = &(rem(&1, 2) != 0)
1..100_000 |> Stream.map(&(&1 * 3)) |> Stream.filter(odd?) |> Enum.sum

# NOTE returns a stream data type, that represents a computation !
1..100_000 |> Stream.map(&(&1 * 3))

# example of infinite stream
stream = Stream.cycle([1, 2, 3])
Enum.take(stream, 10) # [1, 2, 3, 1, 2, 3, 1, 2, 3, 1]

stream = Stream.unfold("hełło", &String.next_codepoint/1)
Enum.take(stream, 3) # ["h", "e", "ł"]
Enum.take(stream, 300) # ["h", "e", "ł", "ł", "o"]

# NOTE good for opening large file, and be sure it will
# be clause even if it fails
stream = File.stream!("path/to/file") # #Function<18.16982430/2 in Stream.resource/3>
Enum.take(stream, 10) # open 10 first lines
