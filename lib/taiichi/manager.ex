defmodule Taiichi.Manager do
  @moduledoc """
  ECSx manager.
  """
  use ECSx.Manager

  alias Taiichi.Components.WorkCreator
  alias Taiichi.Components.Name
  alias Taiichi.Components.Probability

  def setup do
    # Seed persistent components only for the first server start
    # (This will not be run on subsequent app restarts)
    Logger.info("ECSx.Manager setup")
    :ok
  end

  def startup do
    # Load ephemeral components during first server start and again
    # on every subsequent app restart
    Logger.info("ECSx.Manager startup")

    entity = Ecto.UUID.generate()
    WorkCreator.add(entity)
    Name.add(entity, "Product Owner")
    Probability.add(entity, 0.05)

    entity = Ecto.UUID.generate()
    WorkCreator.add(entity)
    Name.add(entity, "Customer Support")
    Probability.add(entity, 0.04)

    entity = Ecto.UUID.generate()
    WorkCreator.add(entity)
    Name.add(entity, "Technical Debt")
    Probability.add(entity, 0.03)

    :ok
  end

  # Declare all valid Component types
  def components do
    [
      Taiichi.Components.WorkSize,
      Taiichi.Components.WorkState,
      Taiichi.Components.WorkRemaining,
      Taiichi.Components.Probability,
      Taiichi.Components.WorkCreator,
      Taiichi.Components.Name
    ]
  end

  # Declare all Systems to run
  def systems do
    [
      Taiichi.Systems.Kanban
    ]
  end
end
