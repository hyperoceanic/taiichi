defmodule Taiichi.Manager do
  @moduledoc """
  ECSx manager.
  """
  use ECSx.Manager

  alias Taiichi.Components.AssignmentEffort
  alias Taiichi.Components.AssignmentWorker
  alias Taiichi.Components.TaskAssignment
  alias Taiichi.Components.Association
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
    HasAName.add(worker_id, "Mark")
    WorkerEffort.add(worker_id, 30)

    assignment_id = Ecto.UUID.generate()
    TaskAssignment.add(assignment_id, task_id)
    AssignmentWorker.add(assignment_id, worker_id)
    AssignmentEffort.add(assignment_id, 37)
    HasAName.add(assignment_id, "Assignment ONE")

    worker_id2 = Ecto.UUID.generate()
    WorkerEffort.add(worker_id2, 25)
    HasAName.add(worker_id2, "Joe")

    assignment_id2 = Ecto.UUID.generate()
    TaskAssignment.add(assignment_id2, task_id)
    AssignmentWorker.add(assignment_id2, worker_id2)
    AssignmentEffort.add(assignment_id2, 17)
    HasAName.add(assignment_id2, "Assignment TWO")
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
      Taiichi.Systems.Driver,
      Taiichi.Systems.TaskWorkCompleter,
      Taiichi.Systems.WorkersExendEffort
    ]
  end
end
