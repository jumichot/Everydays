defmodule FirstTddExample do
  @moduledoc """
    A nice module that lets you uppercase or unvowel every other letter in a sentence.
  """

  @doc """
    Uppercases every other word in a sentence. Examples:

    iex> FirstTddExample.uppercase("you are silly")
    "you ARE silly"
  """
  def uppercase(string) do
    transform_every_other_word(string, &uppercaser/1)
  end

  @doc """
    Removes vowels from every other word in a sentence. Example: 

    iex> FirstTddExample.unvowel("you are silly")
    "you r silly"
  """
  def unvowel(string) do
    transform_every_other_word(string, &unvoweler/1)
  end

  def transform_every_other_word(string, transformation) do
    string
    words = String.split(string)
    words_with_index = Enum.with_index(words)
    transformed_words = Enum.map(words_with_index, transformation)
    Enum.join(transformed_words, " ")
  end

  defp uppercaser(input) do
    transformer(input, &String.upcase/1)
  end

  defp unvoweler({word, index}) do
    transformer({word,index}, fn(word) -> Regex.replace(~r/[aeiou]/, word, "") end)
  end

  defp transformer({word, index}, transformation) do
    cond do
      rem(index, 2) == 0 -> word
      rem(index, 2) == 1 -> transformation.(word)
    end
  end
end
