# to create new process it's simple :
spawn fn -> 1 + 2 end #PID<0.43.0>

# NOTE the process is killed after execution
pid = spawn fn -> 1 + 2 end
Process.alive?(pid) # false

# we can retrieve the current pid of the process :
self() #PID<0.58.0>
Process.alive?(self()) # true


# to send message to a process :
send self(), {:hello, "world"} # {:hello, "world"}
receive do
  {:hello, msg} -> msg
  {:world, msg} -> "won't match"
end # "world"

# you can set timeout
receive do
  {:hello, msg}  -> msg
after
  1_000 -> "nothing after 1s"
end # "nothing after 1s"

# full exemple
parent = self() #PID<0.41.0>
spawn fn -> send(parent, {:hello, self()}) end #PID<0.48.0>
receive do
  {:hello, pid} -> "Got hello from #{inspect pid}"
end # "Got hello from #PID<0.48.0>"

send self(), :hello # :hello
flush()
# :hello
# :ok

#########################################################################
# SPAWN LINKING
#########################################################################
# Elixir applications, we often link our processes to supervisors which 
# will detect when a process 
spawn_link fn -> raise "oops" end

#########################################################################
# TASKS
#########################################################################
# Task to the same, but better logging
# Use Task.start/1 and Task.start_link/1
Task.start fn -> raise "oops" end
# {:ok, #PID<0.55.0>}

