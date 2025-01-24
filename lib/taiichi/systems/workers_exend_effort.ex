defmodule Taiichi.Systems.WorkersExendEffort do
  @moduledoc """
  Documentation for WorkersExendEffort system.
  """
  @behaviour ECSx.System

  alias Taiichi.Components.WorkerEffort
  alias Taiichi.Components.HasAName
  alias Taiichi.Components.WorkerAssignment
  alias Taiichi.Components.EffortRemaining


  @impl ECSx.System
  def run do
    # System logic
    IO.puts "WorkersExendEffort"

    for {task_id, worker_id} <- WorkerAssignment.get_all() do
        worker_name = HasAName.get(worker_id)
        task_name = HasAName.get(task_id)
        effort_remaining = EffortRemaining.get(task_id)
        worker_effort = WorkerEffort.get(worker_id)

        IO.puts("#{worker_name} is assigned to task '#{task_name}' which has #{effort_remaining} left")
        IO.puts("#{worker_name} is going to do #{worker_effort} to task '#{task_name}'.")

        effort_left = max(0, effort_remaining - worker_effort)

        EffortRemaining.update(task_id, effort_left)

    end


    :ok
  end
end
