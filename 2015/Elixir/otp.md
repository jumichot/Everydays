# Episode 014 - OTP Part 1: Servers

Hello again, and welcome to Elixir Sips episode 14 - OTP Part 1: Servers.  In
this episode, we'll cover the basics of OTP Servers:

- What is OTP?
- Implementing GenServer Behaviour
- Asynchronous versus Synchronous calls
- Where to go from here

Let's get started.

## What is OTP?

OTP stands for the "Open Telecom Project."  It's a set of libraries that greatly
simplify a lot of generic work that goes into building systems in Erlang.  The
bit we're going to talk about today specifically is called GenServer, which
stands for Generic Server.

## Implementing GenServer Behaviour

GenServer standardizes a whole host of boilerplate style code that goes into
building a server with state in Erlang.  Elixir then makes implementing OTP
require even less boilerplate code than is required in Erlang (which was already
pretty minimal, to be honest).  In order to implement a GenServer, you must
follow certain conventions.  GenServer handles all the heavy lifting to go from
your minimalistic module definition into a full-on server.

I've been rambling long enough, so let's go ahead and get into it.  First, start
a new project for playing with this stuff:

```bash
mix new otp_server_playground && cd otp_server_playground
```

Next, let's write a quick test to see what our behaviour will look like.  For
the sake of having a domain to play inside of, we're going to have a server that
represents a fridge.  This is based on a fun chapter in the book "Learn You Some
Erlang", which I highly recommend.

### Writing a Test

Open up `test/fridge_server_test.exs` and add the following:

```elixir
defmodule FridgeServerTest do
  use ExUnit.Case

  test "putting something into the fridge" do
    { :ok, fridge } = :gen_server.start_link FridgeServer, [], []
    assert :ok == :gen_server.call(fridge, {:store, :bacon})
  end

  test "removing something from the fridge" do
    { :ok, fridge } = :gen_server.start_link FridgeServer, [], []
    :gen_server.call(fridge, {:store, :bacon})
    assert {:ok, :bacon} == :gen_server.call(fridge, {:take, :bacon})
  end

  test "taking something from the fridge that isn't in there" do
    { :ok, fridge } = :gen_server.start_link FridgeServer, [], []
    assert :not_found == :gen_server.call(fridge, {:take, :bacon})
  end
end
```

Ignore for the moment the `start_link` lines, and just look at the rest of the
test.  This outlines how we expect the FridgeServer to respond.  It looks a bit
foreign, because you're having to call out to the `:gen_server` Erlang module to
make these `call` function calls, but we'll add our own sugar over that.  For
now, let's go ahead and implement the FridgeServer module to be a GenServer and
get these tests passing.

### Implementing Behaviour

The first thing to do is to specify to Elixir that we intend this module to
implement the GenServer behaviour.  Add this to the top of the test file:

```elixir
defmodule FridgeServer do
  use GenServer.Behaviour
end
```

Next, we must implement init/1.  This just is a function that knows how to start
a server off with a given state.  It is implicitly called when you `start_link`
a GenServer.  We'll implement it to just use whatever is passed in as the
argument as its state, for now:

```elixir
  def init(items) do
    { :ok, items }
  end
```

The return value from this function is part of adhering to the OTP Behaviour.
Your init/1 must return a tuple in which the first item is the atom `ok` and the
next item is the state of the server.

If you just run the tests now, you get a crazy looking error that's just a
`function_clause` error.  This is just telling you that OTP tried to call a
function with certain arguments, and no function clause matched the call.

To support storing bacon, we need to implement the `handle_call/1` function.
This is another part of GenServer behaviour.  It should look like the following:

```elixir
  def handle_call({:store, item}, _from, items) do
    { :reply, :ok, [item|items] }
  end
```

Here, we're just going to handle a request to store a given item, and we'll
reply with the expected :ok response, followed by pushing the item into our
server's state.  If you run your tests, the first test should now be passing.

So we can put bacon in, but can we get bacon back out?  Here, we just need to
support a new call.  Go ahead and implement another clause for the `handle_call`
function:

```elixir
  def handle_call({:take, item}, _from, items) do
    { :reply, {:ok, item}, items }
  end
```

Run the tests, and the second test succeeds.  Of course, this is cheating a bit,
because we didn't in any way check to see if our item was in the fridge.  Our
third test exists to force us to actually implement this properly.

```elixir
  def handle_call({:take, item}, _from, items) do
    case Enum.member?(items, item) do
      true ->
        { :reply, {:ok, item}, List.delete(items, item) }
      false ->
        { :reply, :not_found, items }
    end
  end
```

Go ahead and run the tests, and now they should pass.  This wraps up our general
OTP Server basics, but our server's pretty unpleasant to deal with.  Go ahead
and modify the tests to expect a nicer API:

```elixir
defmodule FridgeServerTest do
  use ExUnit.Case

  test "putting something into the fridge" do
    fridge = FridgeServer.start_link
    assert :ok == FridgeServer.store(fridge, :bacon)
  end

  test "removing something from the fridge" do
    fridge = FridgeServer.start_link
    FridgeServer.store(fridge, :bacon)
    assert {:ok, :bacon} == FridgeServer.take(fridge, :bacon)
  end

  test "taking something from the fridge that isn't in there" do
    fridge = FridgeServer.start_link
    assert :not_found == FridgeServer.take(fridge, :bacon)
  end
end
```

Of course, the tests are now failing because we just made up those functions.
Let's implement them:

```elixir
  ### Public API
  def start_link do
    {:ok, pid} = :gen_server.start_link(__MODULE__, [], [])
    pid
  end

  def store(server, item) do
    :gen_server.call server, {:store, item}
  end

  def take(server, item) do
    :gen_server.call server, {:take, item}
  end
```

Run the tests.  They should all succeed.  Fantastic, now we see how to put an
attractive face on our GenServer.

## Summary

In today's episode, we covered the basics of OTP GenServers.  We still haven't
shown off everything they have to offer.  If you want to learn more, the next
step would be to implement `FridgeServer.store` as a `cast` rather than a `call`
- the documentation should be all you'd need to do this.  See you soon!


## Links

- [Learn You Some Erlang - fridge server](http://learnyousomeerlang.com/more-on-multiprocessing)
- [Building OTP apps with Mix](http://elixir-lang.org/getting_started/mix/2.html)
