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
    # Load ephemeral components during first server start and again
    # on every subsequent app restart

    mark = create_worker("Mark", 30)
    joe = create_worker("Joe", 25)

    task1 = create_task( "Task One", 120)
    create_assignment("Assignment ONE M", task1, mark)
    create_assignment("Assignment ONE J", task1, joe)

    task2 = create_task( "Task Two", 155)
    create_assignment("Assignment Two M", task2, mark)

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
      Taiichi.Systems.WorkerAssignmentBalancer,
      Taiichi.Systems.WorkersExendEffort,
      Taiichi.Systems.TaskWorkCompleter,
    ]
  end
end
