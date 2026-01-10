defmodule Taiichi.Components.WorkSize do
  @moduledoc """
  Documentation for WorkSize components.
  """
  use ECSx.Component,
    value: :integer

    def estimate_size() do
        list = [1,1,1,2,2,3,3,5,8,13]
        Enum.random(list)
    end

end
