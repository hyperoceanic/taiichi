defmodule Taiichi.Components.AssignmentWorker do
  @moduledoc """
  Tracks the worker who is on the assignment.
  key = assignment_id, value = worker_id.
  """
  use ECSx.Component,
    value: :binary,
    index: true
end
