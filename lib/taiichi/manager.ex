defmodule Taiichi.Manager do
  @moduledoc """
  ECSx manager.
  """
  use ECSx.Manager

  def setup do
    # Seed persistent components only for the first server start
    # (This will not be run on subsequent app restarts)
    :ok
  end

  def startup do
    # Load ephemeral components during first server start and again
    # on every subsequent app restart

    Taiichi.Components.ProductOwner.create_product_owner("Alice", 0.75)
    
    :ok
  end

  # Declare all valid Component types
  def components do
    [
      Taiichi.Components.ProductOwner,
      Taiichi.Components.Name,
      Taiichi.Components.Probability
    ]
  end

  # Declare all Systems to run
  def systems do
    [
      Taiichi.Systems.Kanban
    ]
  end
end
