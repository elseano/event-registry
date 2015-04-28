defmodule Extensions.JSON do
  alias Postgrex.TypeInfo

  @behaviour Postgrex.Extension

  def init(_parameters, opts),
    do: Keyword.fetch!(opts, :library)

  def matching(_library) do
    [type: "json", type: "jsonb"]
  end

  def format(_library),
    do: :binary

  def encode(%TypeInfo{type: "json"}, map, _state, library),
    do: library.encode!(map)
  def encode(%TypeInfo{type: "jsonb"}, map, _state, library),
    do: <<1, library.encode!(map)::binary>>

  def decode(%TypeInfo{type: "json"}, json, _state, library),
    do: library.decode!(json)
  def decode(%TypeInfo{type: "jsonb"}, <<1, json::binary>>, _state, library),
    do: library.decode!(json)

end

defmodule JSONType do
  @behaviour Ecto.Type

  def cast(%{} = data), do: { :ok, data }
  def cast(_), do: { :error }

  def dump(value), do: Poison.encode(value)
  def load(value), do: Poison.decode(value)

  def type do
    :json
  end
end
