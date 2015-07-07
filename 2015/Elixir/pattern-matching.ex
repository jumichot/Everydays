a = 2 # assign variable, variable can only be assigned that way, on the left side
2 = a # 2
{a, b, c} = {:hello, "world", 42}
a # :hello
b # "world"
# it's kind like ruby array and variables
# need same type and same size to work well

{:ok, result} = {:ok, 13} # you can match for example only :ok cases
#{:ok, result} = {:error, :oops} # for exemple don't match.

[a, b, c] = [1, 2, 3] # works on list
[head | tail] = [1, 2, 3] # matching with head tail
[h|t] = [] # like hd/1, don't works on empty list

list = [1, 2, 3]
[0|list] # [0, 1, 2, 3] # pipe | can be used to prepend value to a list
