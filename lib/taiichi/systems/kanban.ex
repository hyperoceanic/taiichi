defmodule Taiichi.Systems.Kanban do
  @moduledoc """
  Documentation for Kanban system.
  """
  @behaviour ECSx.System

  require Logger

  @impl ECSx.System
  def run do
    # System logic
    {:ok, datetime} = DateTime.now("Etc/UTC")
    Logger.info("Taiichi.Systems.Kanban.run/0 #{datetime}")

     for worker_id <- Taiichi.Components.WorkCreator.get_all() do
         worker_name = Taiichi.Components.Name.get(worker_id)
         worker_probability = Taiichi.Components.Probability.get(worker_id)

         target = :rand.uniform()
         Logger.info("Found #{worker_id}: #{worker_name}: #{worker_probability} vs #{target}")

         if (target <= worker_probability), do: Logger.info("  -> Creating work item from #{worker_name}.")


     end

    :ok
  end
end
