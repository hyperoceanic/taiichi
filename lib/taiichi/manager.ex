defmodule Taiichi.Manager do
  @moduledoc """
  ECSx manager.
  """
  use ECSx.Manager

  alias Taiichi.Components.HasAName
  alias Taiichi.Components.WorkerAssignment
  alias Taiichi.Components.WorkerEffort
  alias Taiichi.Components.EffortRemaining
  alias Taiichi.Components.EffortRequired

  def setup do
    # Seed persistent components only for the first server start
    # (This will not be run on subsequent app restarts)
    :ok
  end

  def startup do
    # Load ephemeral components during first server start and again
    # on every subsequent app restart

    task_id = Ecto.UUID.generate()

    EffortRequired.add(task_id, 120)
    EffortRemaining.add(task_id, 120)
    HasAName.add(task_id, "Task One")

    worker_id = Ecto.UUID.generate()
    WorkerEffort.add(worker_id, 30)
    WorkerAssignment.add(task_id, worker_id)
    HasAName.add(worker_id, "Mark")
  end

  # Declare all valid Component types
  def components do
    [
      Taiichi.Components.HasAName,
      Taiichi.Components.WorkerAssignment,
      Taiichi.Components.WorkerEffort,
      Taiichi.Components.EffortRemaining,
      Taiichi.Components.EffortRequired
    ]
  end

  # Declare all Systems to run
  def systems do
    [
      Taiichi.Systems.WorkersExendEffort,
      Taiichi.Systems.Driver
    ]
  end
end
