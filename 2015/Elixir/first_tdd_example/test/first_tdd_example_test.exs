defmodule FirstTddExampleTest do
  use ExUnit.Case
  doctest FirstTddExample

  test "uppercase doesn't change the first word" do
    assert(FirstTddExample.uppercase("foo") == "foo")
  end

  test "uppercase convert the second word to upppercase" do
    assert(FirstTddExample.uppercase("foo barr") == "foo BARR")
  end

  test "uppercase convert the second word to upppercase" do
    assert(FirstTddExample.uppercase("foo bar baz whee") == "foo BAR baz WHEE")
  end

  test "unvowel doesn't change the first word" do
    assert(FirstTddExample.unvowel("foo") == "foo")
  end

  test "unvowel convert the second word vowels" do
    assert(FirstTddExample.unvowel("foo barr") == "foo brr")
  end

  test "unvowel remove all vowels from other words" do
    assert(FirstTddExample.unvowel("foo bar baz whee") == "foo br baz wh")
  end
end
