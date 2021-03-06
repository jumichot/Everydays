defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling deck of cards
  """

  @doc """
    Returns a list a string representing a deck of playing cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for value <- values, suit <- suits do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Check if a deck contains a card

    ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
      iex> Cards.contains?(deck, "LOL")
      false

  """
  def contains?(deck, hand) do
    Enum.member?(deck, hand)
  end

  @doc """
    Devise a deck into a hand and the remainder of the deck.
    The `hand_size` arguments indicate how many cards should be in the deck

    ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, _} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _} -> "That file doesn't exist"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
