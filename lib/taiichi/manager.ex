defmodule Taiichi.Manager do
  @moduledoc """
  ECSx manager.
  """
  use ECSx.Manager

  alias Taiichi.Components.AssignmentEffort
  alias Taiichi.Components.AssignmentWorker
  alias Taiichi.Components.TaskAssignment
  alias Taiichi.Components.HasAName
  alias Taiichi.Components.WorkerEffort
  alias Taiichi.Components.EffortRemaining
  alias Taiichi.Components.EffortRequired

  def setup do
    # Seed persistent components only for the first server start
    # (This will not be run on subsequent app restarts)
    :ok
  end

  def create_worker(name, effort) do
    id = Ecto.UUID.generate()
    HasAName.add(id, name)
    WorkerEffort.add(id, effort)
    id
  end

  def create_task(name, effort) do
    id = Ecto.UUID.generate()
    HasAName.add(id, name)
    EffortRequired.add(id, effort)
    EffortRemaining.add(id, effort)
    id
  end

  def create_assignment(name, task, worker) do
    id = Ecto.UUID.generate()
    HasAName.add(id, name)
    TaskAssignment.add(id, task)
    AssignmentWorker.add(id, worker)
    AssignmentEffort.add(id, 0)
  end

  def startup do
  end

  # Declare all valid Component types
  @spec components() :: [
          Taiichi.Components.EffortRemaining
          | Taiichi.Components.EffortRequired
          | Taiichi.Components.HasAName
          | Taiichi.Components.TaskAssignment
          | Taiichi.Components.WorkerAssignment
          | Taiichi.Components.WorkerEffort,
          ...
        ]
  def components do
    [
      Taiichi.Components.AssignmentEffort,
      Taiichi.Components.AssignmentWorker,
      Taiichi.Components.TaskAssignment,
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
      Taiichi.Systems.ClientEventHandler,
      Taiichi.Systems.Driver,
      Taiichi.Systems.WorkerAssignmentBalancer,
      Taiichi.Systems.WorkersExendEffort,
      Taiichi.Systems.TaskWorkCompleter
    ]
  end
end
