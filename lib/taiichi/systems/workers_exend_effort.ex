defmodule Taiichi.Systems.WorkersExendEffort do
  @moduledoc """
  Documentation for WorkersExendEffort system.
  """
  @behaviour ECSx.System

  alias Taiichi.Components.WorkerEffort
  alias Taiichi.Components.HasAName
  alias Taiichi.Components.WorkerAssignment
  alias Taiichi.Components.EffortRemaining
  alias Taiichi.Components.TaskAssignment
  alias Taiichi.Components.AssignmentWorker


  @impl ECSx.System
  def run do
    for {assignment_id, worker_id} <- AssignmentWorker.get_all() do

        worker_name = HasAName.get(worker_id)

        assignment_name = HasAName.get(assignment_id)

        IO.puts "#{worker_name} is assigned to assignment named '#{assignment_name}'"

        task_id = TaskAssignment.get(assignment_id)

        task_name = HasAName.get(task_id)
        effort_remaining = EffortRemaining.get(task_id)
        IO.puts("#{assignment_name} is for task '#{task_name}' which has #{effort_remaining} left")

        worker_effort = WorkerEffort.get(worker_id)

        IO.puts("#{worker_name} is going to do #{worker_effort} to task '#{task_name}'.")

        effort_left = max(0, effort_remaining - worker_effort)

        EffortRemaining.update(task_id, effort_left)

    end
  end
end
