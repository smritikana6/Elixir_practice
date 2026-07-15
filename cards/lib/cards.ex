defmodule Cards do
@moduledoc """
Provide methods for creating and handling Cards
"""

  def create_Deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamond"]

    for value <- values, suit <- suits do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def conatins?(deck, card) do
    Enum.member?(deck, card)
  end

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @spec load(
          binary()
          | maybe_improper_list(
              binary() | maybe_improper_list(any(), binary() | []) | char(),
              binary() | []
            )
        ) :: any()

  def load(filename) do
    # Code we should not use for error handing
    # if( status == :ok ) do
    #   :erlang.binary_to_term binary
    # else
    #   IO.puts("File Does Not Exists")
    # end

    # simpler pattern matching
    # {status, binary} = File.read(filename)
    # case status do
    #   :error -> IO.puts("File Does not Exists")
    #   :ok ->  :erlang.binary_to_term binary
    # end

    # more complicated
    case File.read(filename) do
      {:error, _reason} -> "File Does not Exists"
      {:ok, binary} -> :erlang.binary_to_term(binary)
    end
  end

  def execute_game(hand_size) do
    create_Deck()
    |> shuffle()
    |> deal(hand_size)
  end
end
