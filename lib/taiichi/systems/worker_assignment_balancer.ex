defmodule Taiichi.Systems.WorkerAssignmentBalancer do
  @moduledoc """
  Documentation for WorkerAssignmentBalancer system.
  """
  @behaviour ECSx.System

  alias Taiichi.Components.AssignmentWorker
  alias Taiichi.Components.WorkerEffort
  alias Taiichi.Components.AssignmentEffort
  alias Taiichi.Components.HasAName


  def get_live_assignments(worker_id) do
    dbg AssignmentWorker.search(worker_id)
    |> Enum.filter(&AssignmentWorker.exists?(&1) )
  end

  @impl ECSx.System
  def run do
    # System logic
    for {worker_id, effort} <- WorkerEffort.get_all() do

        worker_name = HasAName.get(worker_id)

        # TODO: I think search should have just returning rows that existed?
        assignments = get_live_assignments(worker_id) # AssignmentWorker.search(worker_id)
        count = Enum.count(assignments)

        if (count > 0) do
            new_effort = div(effort,count)

            IO.puts("Balancing worker #{worker_name}, effort #{effort}, updating #{count} assignments to #{new_effort}.")

            for assignment_id <- assignments do
                worker_check = AssignmentWorker.get(assignment_id)
                if (worker_check != worker_id), do: IO.puts("BAAAAD")
                
                assignment_name = HasAName.get(assignment_id)
                old_effort = AssignmentEffort.get(assignment_id)
                IO.puts("Updating assignment '#{assignment_name}' from #{old_effort} to #{new_effort}.")
                AssignmentEffort.update(assignment_id, new_effort)
            end
        end
    end
  end
end
