defmodule EventRegistry.Event do
  use EventRegistry.Web, :model

  schema "events" do
    field :name, :string
    field :data, JSONType

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w(data)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ nil) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def write do
    cs = EventRegistry.Event.changeset(%EventRegistry.Event{}, %{ name: "Hi", data: %{ remote: "http://www.google.com" } })
    EventRegistry.Repo.insert(cs)
  end

  def json_representation(event) do
    Dict.merge(%{
      id: event.id,
      name: event.name,
      created_at: event.inserted_at
    }, event.data)
  end
end
