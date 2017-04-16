defmodule IslandsEngine.GameSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: :game_supervisor)
  end

  def init([]) do
    children = [
      worker(IslandsEngine.Game, [], restart: :transient)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end
