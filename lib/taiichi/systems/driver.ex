defmodule Taiichi.Systems.Driver do
  @moduledoc """
  Documentation for Driver system.
  """
  @behaviour ECSx.System

  @impl ECSx.System
  def run do
    # System logic
    IO.puts "----------------------------------------------"
    :ok
  end
end
