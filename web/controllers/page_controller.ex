defmodule EventRegistry.PageController do
  use EventRegistry.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
