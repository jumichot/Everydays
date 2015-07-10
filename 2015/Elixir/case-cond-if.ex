case {1, 2, 3} do
  {4, 5, 6} ->
    "This clause won't match"
  {1, x, 3} ->
    # here x = 2
    "This clause will match and bind x to 2 in this clause"
  _ ->
    "This clause would match any value"
end

# here no x ?

x = 9

# If you need to match against an existing variable
# you need the pin operator
result = case {1, 9, 3} do
  {4, 5, 6} ->
    "This clause won't match"
  {1, ^x, 3} ->
    "I want that"
  _ ->
    "This clause would match any value"
end

result # = I want that

# you can add conditions for matching
case {1, 2, 3} do
   {1, x, 3} when x > 0 ->
     "Will match"
   _ ->
     "Would match, if guard condition were not satisfied"
end
 # "Will match"

# NOTE Errors in guard condition (for example x > 0), will not
# throw exception and break, this will juste fail silently
# the matcher


# NOTE If none of the clauses match, an error is raised
f = fn
  x, y when x > 0 -> x + y
  x, y -> x * y
end

f.(1, 3) # 4
f.(-1, 3) # -3

# cond is a sort of if else

cond do
  2 + 2 == 5 ->
    "This will not be true"
  2 * 2 == 3 ->
    "Nor this"
  1 + 1 == 2 ->
    "But this will"
end
#"But this will"

cond do
  2 + 2 == 5 ->
    "This is never true"
  2 * 2 == 3 ->
    "Nor this"
  true ->
    "This is always true (equivalent to else)"
end
# if none condition matche, raise an error
# so it's good to add a default value

lol = cond do
  0 ->
    "1 is considered as true"
end
# "1 is considered as true"
# all value excepte false and nil are considered true

###################################################
# if and unless are defined via macro, not built-in

###################################################
# do end block can be written do:

if true, do: (
  a = 1 + 2
  a + 10
)
# 13

# you can pass else with keyword list syntax
if false, do: :this, else: :that
