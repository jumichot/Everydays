#########################################################################
#BOOLEAN AND ATOMS
#########################################################################
is_boolean(true) # true
is_boolean(1) # false
is_integer(3.2) # false
:true == :belette # false
true == :true # true boolean are atoms
is_atom(:true) # true
is_atom(true) # true

#########################################################################
# STRINGS
#########################################################################
IO.puts "Hello
from Elixir"
"hellö" # utf8 strings
"hello #{:worldT}" # string interpolation
"hello #{:worldT}" == "hello #{"worldT"}" == "hello #{'worldT'}"
toto = IO.puts "toto" # IO.puts return :ok
toto == :ok #true

is_binary("hellö") # true : string are binaries internally
byte_size("hellö") # 6 even if 5 char because the ô take 2 bytes
String.length("hellö") # 5
String.upcase("hellö") # HELLO



# TODO Single-quoted and double-quoted representations are not equivalent in Elixir as they are represented by different types
'hello' != "hello" # Single-quotes are char lists, double-quotes are strings. 


#########################################################################
# ANONYMOUS FUNCTION
#########################################################################
add = fn a, b -> a + b end
add.(2,3) # 5
is_function(add) # true
is_function(add, 1) # false
is_function(add, 2) # true

IO.puts "====================="

add_two = fn a -> add.(2, a) end
add_two.(4) # 6 -> function are clojure, they access to the parent scope

# variable declared in function do not got to parent scope
x = 42
(fn -> x = 0 end).()
x # 42

#########################################################################
# (LINKED) LIST
#########################################################################

list = [1, 2, true, 3]
length list #4

[1, 2, 3] ++ [4, 5, 6] # list concatenation
[1, true, 2, false, 3, true] -- [true, false] # [1, 2, 3, true]

# TODO ! the -- affect only the previous list !
[1, 2, 3] ++ [4, 5, 6] ++ [34,2] -- [1,2,3,4,5] # [1, 2, 3, 4, 5, 6, 34]

list = [1,2,3]
hd(list) # 1
tl(list) # [2,3] not working ! I don't know why for the moment.. works in repl
# hd [] # error, can't get head on empty list
[104, 101, 108, 108, 111] # hello -> printable ascii numbers, elixir show them


# IO.puts
# IO.puts
# IO.puts
