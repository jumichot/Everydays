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
1..100_000 |> Stream.map(&(&1 * 3)) |> Stream.filter(odd?) |> Enum.sum
