# Anonymous functions
print_name = fn
  {:person, first_name, last_name} -> first_name <> " " <> last_name
end

# to call a anonymous function :
print_name.({:person, "Julien", "Michot"}) #"Josh Adams"
print_name.('toto') # ** (FunctionClauseError) no function clause matching in :erl_eval."-inside-an-interpreted-fun-"/1

# silly example
calculate_bill = fn
  [{:item, price}, {:item, price2}] -> price + price2
  {:item, price} -> price
end

calculate_bill.([{:item, 20}, {:item, 10}]) #30
calculate_bill.({:item, 35}) #35

#NOTE invoke immediataly a anonymous function
(fn -> "foo" end).() # "foo"

# functions are first class citizen, you can pass them as arguments
add = fn
  num -> (fn num2 -> num + num2 end)
end

add3 = add.(3)
add3.(5) #8

greet_person = fn
  greeter, {:person, first_name, last_name} -> greeter.(first_name <> " " <> last_name)
end

polite_greeter = fn
  name -> "Hello, #{name}, nice to meet you !"
end

terse_greeter = fn
  name -> "Hi #{name}"
end

person = {:person, "Julien", "Michot"}

greet_person.(polite_greeter, person) # "Hello, Julien Michot, nice to meet you !"
greet_person.(terse_greeter, person) # "Hi Julien Michot"
