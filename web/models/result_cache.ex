defmodule EventRegistry.ResultCache do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: EventRegistry.ResultCache)
  end

  def init(:ok) do
    { :ok, HashDict.new }
  end

  def handle_call({ :get, key }, _sender, dict) do
    if HashDict.has_key?(dict, key) do
      { :ok, data } = HashDict.fetch(dict, key)
      { :reply, { :hit, data }, dict }
    else
      { :reply, :miss, dict }
    end
  end

  def handle_cast({ :put, key, result }, dict) do
    { :noreply, HashDict.put(dict, key, result) }
  end

  def get(key),         do: GenServer.call(EventRegistry.ResultCache, { :get, key })
  def put(key, result), do: GenServer.cast(EventRegistry.ResultCache, { :put, key, result })
end
