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
