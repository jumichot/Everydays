defmodule Identicon do
  def main(input) do
    input
    |> hash_string
    |> pick_color
  end

  def pick_color(image) do
    %Identicon.Image{hex: [r, g, b | _tail]} = image
    %Identicon.Image{image | color: {r, g, b}}
  end

  def hash_string(input) do
    hex = :crypto.hash(:md5, input)
    |> :erlang.binary_to_list

    %Identicon.Image{hex: hex}
  end
end
