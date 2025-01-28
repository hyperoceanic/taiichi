defmodule Taiichi.Systems.ClientEventHandler do
  @moduledoc """
  Documentation for ClientEventHandler system.
  """
  @behaviour ECSx.System

  alias Taiichi.Manager

  @impl ECSx.System
  def run do
    client_events = ECSx.ClientEvents.get_and_clear()

    Enum.each(client_events, &process_one/1)
  end

  defp process_one({%{board_id: my_id}, :start_sim}) do
    IO.puts("***************** START SIM #{my_id} ********************")

    mark = Manager.create_worker("Mark 2", 30)
    joe = Manager.create_worker("Joe 2", 25)

    task1 = Manager.create_task("Task THREE", 120)
    Manager.create_assignment("Assignment THREE M", task1, mark)
    Manager.create_assignment("Assignment THREE J", task1, joe)

    task2 = Manager.create_task("Task FOUR", 155)
    Manager.create_assignment("Assignment FOUR M", task2, mark)
  end
end
