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

        task_id = TaskAssignment.get(assignment_id)

        task_name = HasAName.get(task_id)
        effort_remaining = EffortRemaining.get(task_id)
        worker_effort = WorkerEffort.get(worker_id)

        IO.puts """
                    Task: '#{task_name}'
                      Assignment: '#{assignment_name}'
                      Worker: #{worker_name}
                      Effort Remaining: #{effort_remaining}
                      Effort to apply: #{worker_effort}
                """

        effort_left = max(0, effort_remaining - worker_effort)

        EffortRemaining.update(task_id, effort_left)

    end
  end
end
