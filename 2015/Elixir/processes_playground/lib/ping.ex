defmodule Ping do
  def start do
    await
  end

  def await do
    receive do
      {:pong, pid} -> Process.send(pid, {:ping, self}, [])
    end
    # need to call start to respond to more message
    start
  end
end

