defmodule Taiichi.Systems.Kanban do
  @moduledoc """
  Documentation for Kanban system.
  """
  @behaviour ECSx.System

  require Logger

  @impl ECSx.System
  def run do
    # System logic
    {:ok, datetime} = DateTime.now("Etc/UTC")
    Logger.info("Taiichi.Systems.Kanban.run/0 #{datetime}")
    :ok
  end
end
