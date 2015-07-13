# NOTE .ex are compiled filed to bytecode, .exs is for scripting
defmodule Math do
  def sum(a, b) do
    a + b
  end
end

IO.puts Math.sum(1, 2)

#########################################################################
# NAMED FUNCTIONS
#########################################################################
# NOTE 2 type of methods with def (public) and defp (private)

# support for multiple clauses
defmodule Math do
  def zero?(0) do
    true
  end

  def zero?(x) when is_number(x) do
    false
  end
end

Math.zero?(0)  #=> true
Math.zero?(1)  #=> false

Math.zero?([1,2,3]) #=> ** (FunctionClauseError)


#########################################################################
# FUNCTION CAPTURING
#########################################################################
# NOTE you can capture functions

Math.zero?(0) # true
fun = &Math.zero?/1
is_function fun # true
fun.(0) # true

(&is_function/1).(fun)#  true

# NOTE capture syntax can also be used as a shortcut for creating functions
# The &1 represents the first argument passed into the function.
fun = &(&1 + 1)
fun.(1) # 2
&(&1 + &2).(1,3)
fun.(1,3) # 4

# same as . The syntax above is useful for short function definitions.
fn x -> x + 1 end

fun = &List.flatten(&1, &2)
fun.([1, [[2], 3]], [4, 5]) # [1, 2, 3, 4, 5]

#########################################################################
# DEFAULT ARGUMENT
#########################################################################
# NOTE: you can add default with \\ value_arg
defmodule Concat do
  def join(a, b, sep \\ " ") do
    a <> sep <> b
  end
end

IO.puts Concat.join("Hello", "world")      #=> Hello world
IO.puts Concat.join("Hello", "world", "_") #=> Hello_world

defmodule DefaultTest do
  def dowork(x \\ IO.puts "hello") do
    x
  end
end

DefaultTest.dowork # hello :ok
DefaultTest.dowork # 123
DefaultTest.dowork # hello :ok

# NOTE If a function with default values has multiple clauses,
# it is recommended to create a function head (without an actual body),
# just for declaring defaults:

defmodule Concat do
  def join(a, b \\ nil, sep \\ " ")

  def join(a, b, _sep) when is_nil(b) do
    a
  end

  def join(a, b, sep) do
    a <> sep <> b
  end
end

IO.puts Concat.join("Hello", "world")      #=> Hello world
IO.puts Concat.join("Hello", "world", "_") #=> Hello_world
IO.puts Concat.join("Hello")               #=> Hello

# NOTE be carefull with overlapping functions
# here it would trigger a warning
defmodule Concat do
  def join(a, b) do
    IO.puts "***First join"
    a <> b
  end

  def join(a, b, sep \\ " ") do
    IO.puts "***Second join"
    a <> sep <> b
  end
end
# concat.ex:7: this clause cannot match because a previous clause at line 2 always matches

