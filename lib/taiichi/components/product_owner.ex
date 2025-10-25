defmodule Taiichi.Components.ProductOwner do
  @moduledoc """
  This tag identifies an entity as a Product Owner in the Kanban system.
  """
  use ECSx.Tag

  alias Taiichi.Components.Probability
  alias Taiichi.Components.Name

  def create_product_owner(name, probability) do
    entity = Ecto.UUID.generate()

    add(entity)
    Name.add(entity, name)
    Probability.add(entity, probability)
    entity
  end

  def product_owner_may_create_backlog_items(entity) do
    probability = Probability.get(entity)
    name = Name.get(entity)
    IO.puts("Entity: #{entity}, Name: #{name}, Probability: #{probability}")
  end
end
