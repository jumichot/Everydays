#########################################################################
# KEYWORD LIST
#########################################################################
# NOTE in elixir to represent hash you have a list of tuples
# if the first item of the tuple is an atom then it represents a keyword list
# Keys must be atoms.
# Keys are ordered, as specified by the developer.
# Keys can be given more than once.
list = [{:a, 1}, {:b, 2}] # [a: 1, b: 2]
list == [a: 1, b: 2] # true
list[:a]# 1

# NOTE keyworkd list are list (linked list), so same pros and cons
# and same operators like -- and ++
list ++ [c: 3] # [a: 1, b: 2, c: 3]
[a: 0] ++ list # [a: 0, a: 1, b: 2]

# The do: and else: pairs are keyword lists
if false, do: :this, else: :that
if(false, [do: :this, else: :that]) # equivalent

# NOTE : keyword list are use mainly to pass options

# NOTE pattern matching possible with keyword list
[a: a] = [a: 1]
a # 1

# but rarely used because need same size and same order
[a: a] = [a: 1, b: 2] #error not the same size
[b: b, a: a] = [a: 1, b: 2] # error not the same order

#########################################################################
# MAPS
#########################################################################
# NOTE go to structure for key value
# Maps allow any value as a key.
# Maps' keys do not follow any ordering

map = %{:a => 1, 2 => :b}
map[:a] # 1
map[2] # :b
map[:c] # nil


# if you insert two same keys, last one win
%{1 => 1, 1 => 2} # %{1 => 2}

# if keys are all atoms we can use this syntax (like ruby)
map = %{a: 1, b: 2} # %{a: 1, b: 2}

%{n => 1} # Error, variable can't be keys
# But can be used to fecth a value from a hash
map = %{:a => 1, 2 => :b}
x = :a
map[x] # 1


%{} = %{:a => 1, 2 => :b} # empty map match all maps
%{:a => a} = %{:a => 1, 2 => :b}
a # 1

%{:c => c} = %{:a => 1, 2 => :b} #match error
# match if the keys are present

# Map api to manipulate maps
Map.get(%{:a => 1, 2 => :b}, :a) #1
# convert a map to a list
Map.to_list(%{:a => 1, 2 => :b})

# another way of accessing map value
map = %{:a => 1, 2 => :b}
map.a # 1
map.c # Error ! the key need to exist, seems like fetch

# updating value
%{map | :a => 2} # %{:a => 2, 2 => :b}
%{map | :c => 3} # ArgumentError, the c: key doesn't exist


#########################################################################
# DICT
#########################################################################

# both keyword list and map are dict
# NOTE Dict are an interface (it's called behaviour) for keyword list and map
keyword = []
map = %{}
Dict.put(keyword, :a, 1) # [a: 1]
Dict.put(map, :a, 1) # %{a: 1}


dict = [foo: 'bar', baz: 'beez', elixir: 'sips']
Dict.delete(dict, :foo) # [baz: 'beez', elixir: 'sips']
Dict.drop(dict, [:foo, :baz]) # [elixir: 'sips']
# Dict.empty(dict) # don't work ?
Dict.equal?(dict, dict) # true


Dict.fetch(dict, :foo)  # {:ok, 'bar'}
Dict.fetch(dict, :fos)  # :error
Dict.fetch!(dict, :foo) # 'bar'
Dict.fetch!(dict, :fozo) # ** (KeyError) key :fozo not found in: [foo: 'bar', baz: 'beez', elixir: 'sips']
