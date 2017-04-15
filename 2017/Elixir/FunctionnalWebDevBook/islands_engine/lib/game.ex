defmodule IslandsEngine.Game do
  use GenServer
  defstruct player1: :none, player2: :none

  alias IslandsEngine.{Game, Player}

  def start_link(name) when is_binary(name) and byte_size(name) > 0 do
    GenServer.start_link(__MODULE__, name, name: {:global, "game:#{name}"})
  end

  def stop(pid) do
    GenServer.cast(pid, :stop)
  end

  def handle_cast(:stop, state) do
    {:stop, :normal, state}
  end

  def init(name) do
    {:ok, player1} = Player.start_link(name)
    {:ok, player2} = Player.start_link()
    {:ok, %Game{player1: player1, player2: player2}}
  end

  def add_player(pid, name) when name != nil do
    GenServer.call(pid, {:add_player, name})
  end

  def handle_call({:add_player, name}, _from, state) do
    Player.set_name(state.player2, name)
    {:reply, :ok, state}
  end

  def set_island_coordinates(pid, player, island, coordinates) when is_atom player and is_atom island do
    GenServer.call(pid, {:set_island_coordinates, player, island, coordinates})
  end

  def handle_call({:set_island_coordinates, player, island, coordinates}, _from, state) do
    Map.get(state, player) |> Player.set_island_coordinates(island, coordinates)
    {:reply, :ok, state}
  end

  def guess_coordinate(pid, player, coordinate) when is_atom player and is_tuple coordinate do
    GenServer.call(pid, {:guess, player, coordinate})
  end

  def handle_call({:guess, player, coordinate}, _from, state) do
    opponent = opponent(state, player)
    opponent_board = Player.get_board(opponent)
    response = Player.guess_coordinate(opponent_board, coordinate)
    |> forest_check(opponent, coordinate)
    |> win_check(opponent, state)
  end


  defp forest_check(:miss, _opponent, _coordinate), do: {:miss, :none}
  defp forest_check(:hit, opponent, coordinate) do
    island_key = Player.forested_island(opponent, coordinate)
    {:hit, island_key}
  end

  defp win_check({hit_or_miss, :none}, _opponent, state) do
    {:reply, {hit_or_miss, :none, :no_win}, state}
  end
  defp win_check({:hit, island_key}, opponent, state) do
    win_status =
    case Player.win?(opponent) do
      true -> :win
      false -> :no_win
    end
    {:reply, {:hit, island_key, win_status}, state}
  end

  defp opponent(state, :player1), do: state.player2
  defp opponent(state, _player), do: state.player1

  def call_demo(pid) do
    GenServer.call(pid, :demo)
  end
  def handle_call(:demo, _from, state) do
    {:reply, state, state}
  end
end
