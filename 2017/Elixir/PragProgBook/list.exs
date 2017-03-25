defmodule MyList do
  def reduce([], value, _), do: value
  def reduce([head|tail], value, func) do
    reduce(tail, func.(head, value), func)
  end

  def mapsum([], _func), do: 0
  def mapsum([head|tail], func) do
    func.(head) + mapsum(tail, func)
  end

  def max([a, b]) do
    if a > b, do: a, else: b
  end
  def max([head | tail]) do
    max(head, max(tail))
  end
end
