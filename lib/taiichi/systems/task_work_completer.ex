defmodule Taiichi.Systems.TaskWorkCompleter do
  @moduledoc """
  Documentation for TaskWorkCompleter system.
  """
  @behaviour ECSx.System

  alias Taiichi.Components.HasAName
  alias Taiichi.Components.EffortRemaining
  alias Taiichi.Components.TaskAssignment
  alias Taiichi.Components.AssignmentWorker

  @impl ECSx.System
  def run do
    for {assignment_id, worker_id} <- AssignmentWorker.get_all() do
        task_id = TaskAssignment.get(assignment_id)

        effort_remaining = EffortRemaining.get(task_id)

        if effort_remaining == 0 do
            worker_name = HasAName.get(worker_id)
            task_name = HasAName.get(task_id)
            IO.puts("#{worker_name} is has finished working on '#{task_name}'.")

            AssignmentWorker.remove(assignment_id)
            TaskAssignment.remove(task_id)
        end

    end
  end
end
