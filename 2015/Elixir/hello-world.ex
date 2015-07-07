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

 "foo" <> "bar" # "foobar" => string concatenation


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

#########################################################################
# TUPLES
#########################################################################
tuple = {:ok, "hello"} # like list, can contain any value
put_elem(tuple, 1, "world") #{:ok, "world"} setter can add an element where you like
# tuple not changed ! immutable data
# a new tuple is sent
elem(tuple,1) # getter
tuple_size tuple # 2, size of the tuple

 list = [1|[2|[3|[]]]] #[1, 2, 3]

# list -> linked list via pointer in memory
# list -> length slow : need to traverse the whole list
# list -> prepending is fast, appending is slow

# tuples -> element contiguously in memory
# tuples -> accessing by index or get length is fast
# tuples -> but slow for adding or modifying because need to rebuild all the tuple, immutability
# often use in return result of function ex : File.read

# CONVENTIONS
# size if the operation is in constant time (i.e. the value is pre-calculated) : for tuples, bite_size in a string,
# length if the operation requires explicit counting : for list, for strings length 

#########################################################################
# OPERATOR
#########################################################################
false or is_atom(:example) # and / or expect boolean value
false and error("This error will never be raised") # fail fast on the left
# and et or map to andalso in erling and orelse

#||, && and !  # opeators, false and nil are falsy
# or and operators accepts only boolean as first value
1 == 1.0 #true
1 === 1.0 #false === more strict with float value

# comparing different types
# number < atom < reference < functions < port < pid < tuple < maps < list < bitstring
