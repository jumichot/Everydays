defmodule ListSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init do
    child_processes = [worker(ListServer, list)]
    supervise child_processes, strategy: :one_for_one
  end
end
