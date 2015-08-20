defmodule ListServerTest do
  use ExUnit.Case

  # clear the list server before each test
  setup do
    ListServer.start_link
    ListServer.clear
  end

  test "it starts out empty" do
    assert ListServer.items == []
  end

  test "it lets us add things to the list" do
    ListServer.add "book"
    assert ListServer.items == ["book"]
  end

  test "it lets remove things form the list" do
    ListServer.add "book"
    ListServer.add "magazine"
    ListServer.remove "book"
    assert ListServer.items == ["magazine"]
  end
end
