defmodule Unix do
  def ps_ax do
    """
  PID TTY      STAT   TIME COMMAND
 3109 pts/1    Ss     0:00 bash
 3862 ?        SNl    0:11 /usr/bin/python3 /usr/bin/update-manager --no-update --no-focus-on-map
 5286 pts/6    Ss     0:00 -bash
 5465 pts/6    Sl+    0:00 vim foo
 6798 pts/3    Sl+    0:00 vim test/pipe_operator_playground_test.exs
    """
  end

  def grep(input, match) do
    String.split(input, "\n")
    |> Enum.filter(fn(line) -> Regex.match?(match,line) end)
  end

  def awk(lines, column) do
    Enum.map(lines, fn(line) ->
      stripped = String.strip(line)
      |> Unix.regex_split(~r/ /)
      |> Enum.at(column-1)
    end)
  end

  def regex_split(lines, regex) do
    Regex.split(regex,lines, trim: true)
  end

end
defmodule PipeOperatorPlaygroundTest do
  use ExUnit.Case

  test "grep(lines, thing) returnss lines that match 'thing'" do
    lines =  """
    foo
    bar
    thing foo
    baz
    thing qux
    """
    output = ["thing foo", "thing qux"]
    assert Unix.grep(lines, ~r/thing/) == output
  end

  test "awk(inpout,1) splits on whitespace and return the first column" do
    input = ["foo bar", " baz   qux"]
    output = ["foo", "baz"]
    assert Unix.awk(input, 1) == output
  end

  test "the whole pipeline works" do
    # not very clear
    assert(Unix.awk(Unix.grep(Unix.ps_ax, ~r/vim/), 1)) == ["5465", "6798"]
    # very clear with pipe operator
    assert(Unix.ps_ax |> Unix.grep(~r/vim/) |> Unix.awk(1)) == ["5465", "6798"]
  end
end
