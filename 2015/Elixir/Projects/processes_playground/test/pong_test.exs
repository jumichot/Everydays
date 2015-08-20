defmodule PongTest do
  use ExUnit.Case

  test "it responds to a ping with a ping" do
    ping = spawn_link(Pong, :start, [])
    Process.send ping, {:ping, self}, []
    assert_receive {:pong, ^ping}
  end

  test "it responds to two pings with two pings" do
    ping = spawn_link(Pong, :start, [])
    Process.send ping, {:ping, self}, []
    assert_receive {:pong, ^ping}
    Process.send ping, {:ping, self}, []
    assert_receive {:pong, ^ping}
  end
end
