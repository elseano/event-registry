defmodule EventRegistry.EventController do
  use EventRegistry.Web, :controller
  alias EventRegistry.ResultCache

  plug :action

  def index(conn, %{ "from" => from }) do
    offset = String.to_integer(from)
    json conn, %{ events: get_json_events(offset), next: offset + 10 }
  end

  def index(conn, _params) do
    json conn, %{ events: get_json_events(0), next: 11 }
  end

  defp get_json_events(offset) do
    key = "event-list-#{offset}"
    case ResultCache.get(key) do
      { :hit, data } -> data
      :miss ->
        query = from w in EventRegistry.Event,
          limit: 10,
          offset: ^offset

        data = EventRegistry.Repo.all(query)
        result = Enum.map data, &EventRegistry.Event.json_representation(&1)

        ResultCache.put(key, result)
        result
    end
  end
end
