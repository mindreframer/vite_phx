defmodule DemoWeb.CounterLive do
  use DemoWeb, :live_view
  alias DemoWeb.Live.Helper

  def mount(_params, %{}, socket) do
    {:ok, assign(socket, :current, "top-current")}
  end

  def render(assigns) do
    ~L"""
    <div class="container">
      <h3>Counter for <%= @current %> </h3>
      <div>
        <%= Helper.a_helper() %>
      </div>
    </div>
    """
  end
end
