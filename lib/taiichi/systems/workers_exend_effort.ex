defmodule Taiichi.Systems.WorkersExendEffort do
  @moduledoc """
  Documentation for WorkersExendEffort system.
  """
  @behaviour ECSx.System

  alias Taiichi.Components.HasAName
  alias Taiichi.Components.EffortRemaining
  alias Taiichi.Components.TaskAssignment
  alias Taiichi.Components.AssignmentWorker
  alias Taiichi.Components.AssignmentEffort

  @impl ECSx.System
  def run do
    for {assignment_id, worker_id} <- AssignmentWorker.get_all() do

        worker_name = HasAName.get(worker_id)
        assignment_name = HasAName.get(assignment_id)

        task_id = TaskAssignment.get(assignment_id)
        task_name = HasAName.get(task_id)
        effort_remaining = EffortRemaining.get(task_id)

        assignment_effort = AssignmentEffort.get(assignment_id)

        IO.puts """

                Assignment: '#{assignment_name}'
                    Task: '#{task_name}'
                    Worker: #{worker_name}
                    Effort Remaining: #{effort_remaining}
                    Effort to apply: #{assignment_effort}
                """

        effort_left = max(0, effort_remaining - assignment_effort)

        EffortRemaining.update(task_id, effort_left)

    end
  end
end
