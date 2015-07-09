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
