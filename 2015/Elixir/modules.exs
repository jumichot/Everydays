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

################
# MIX MODULES
###############
# see mix_example folder

# first way of compile it : pass the module as parameter of iex
# iex lib/modules_example.ex
# iex(1)> ModulesExample.publish("lol")
# "lol"

# second way with elixirc :
# elixirc lib/modules_example.ex
# generate a compiled file 2015/Elixir/mix_example/modules_example/Elixir.ModulesExample.beam
# and again it's available in iex
# iex(1)> ModulesExample.publish("lol")
# "lol"

# you can can define a module in the reple
output = defmodule Foo do
  def bar do
    "lol"
  end
end

# It's a tuple !
# {:module, Foo,
#  <<70, 79, 82, 49, 0, 0, 4, 140, 66, 69, 65, 77, 69, 120, 68, 99, 0, 0, 0, 92, 131, 104, 2, 100, 0, 14, 101, 108, 105, 120, 105, 114, 95, 100, 111, 99, 115, 95, 118, 49, 108, 0, 0, 0, 2, 104, 2, ...>>,
#  {:bar, 0}}
# Structure : an item ":module", the name of the constant, and the binary bytecode
# You can send a module over the network to a node without give him access to the network
# finaly contain a tuple defining the method availables in the module

#########################
# DOCUMENTATION
#########################
# add ex_doc as dependency { :ex_doc, github: "elixir-lang/ex_doc" }
# mix deps.get
# mix deps.get
# mix docs


