defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "Create make 20 cards" do
    deck_length = length(Cards.create_deck)
    assert deck_length == 20
  end

  test "shuffling a deck randomize it" do
    deck = Cards.create_deck
    refute Cards.shuffle(deck) == deck
    # equal : assert Cards.shuffle(deck) != deck
  end
end
