defmodule Taiichi.Components.WorkerAssignment do
  @moduledoc """
  A worker takes part in a Worker has many Assignments.
  """
  use ECSx.Component,
    value: :binary,
    index: true
end
