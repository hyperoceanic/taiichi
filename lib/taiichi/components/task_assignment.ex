defmodule Taiichi.Components.TaskAssignment do
  @moduledoc """
  Documentation for TaskAssignment components. The key is the Assignment
  and the value is the Task that the assignment is for.
  """
  use ECSx.Component,
    value: :binary,
    index: true
end
