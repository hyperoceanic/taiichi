defmodule Taiichi.Systems.Kanban do
  @moduledoc """
  Documentation for Kanban system.
  """
  @behaviour ECSx.System

  alias Taiichi.Components.ProductOwner

  @impl ECSx.System
  def run do
    product_owners = ProductOwner.get_all()

    Enum.each(product_owners, fn entity ->
      ProductOwner.product_owner_may_create_backlog_items(entity)
    end)

    # System logic
    :ok
  end
end
