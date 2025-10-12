defmodule Taiichi.Systems.Kanban do
  @moduledoc """
  Documentation for Kanban system.
  """
  @behaviour ECSx.System

  alias Taiichi.Components.Probability
  alias Taiichi.Components.Name

  @impl ECSx.System
  def run do

     for {entity, name} <- Name.get_all() do
        probability = Probability.get(entity)
        IO.puts("Entity: #{entity}, Name: #{name}, Probability: #{probability}")

     end

    # System logic
    :ok
  end
end
