defmodule Identicon do
  def main(input) do
    input
    |> hash_string
    |> pick_color
    |> build_grid
  end

  def build_grid(%Identicon.Image{hex: hex_list} = image) do
    grid = hex_list
    |> Enum.chunk(3)
    |> Enum.map(&mirror_row/1)
    |> List.flatten
    |> Enum.with_index

    %Identicon.Image{image | grid: grid}
  end


  def mirror_row([first, second | _tail] = row) do
    row ++ [second, first]
  end


  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  def hash_string(input) do
    hex = :crypto.hash(:md5, input)
    |> :erlang.binary_to_list

    %Identicon.Image{hex: hex}
  end
end
