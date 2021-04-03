defmodule DemoWeb.PageLive do
  use DemoWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: "", results: %{})}
  end

  @impl true
  def handle_event("suggest", %{"q" => query}, socket) do
    {:noreply, assign(socket, results: search(query), query: query)}
  end

  @impl true
  def handle_event("search", %{"q" => query}, socket) do
    case search(query) do
      %{^query => vsn} ->
        {:noreply, redirect(socket, external: "https://hexdocs.pm/#{query}/#{vsn}")}

      _ ->
        {:noreply,
         socket
         |> put_flash(:error, "No dependencies found matching \"#{query}\"")
         |> assign(results: %{}, query: query)}
    end
  end

  defp search(query) do
    for {app, desc, vsn} <- started_apps(),
        app = to_string(app),
        String.starts_with?(app, query) and not List.starts_with?(desc, ~c"ERTS"),
        into: %{},
        do: {app, vsn}
  end

  defp started_apps() do
    [
      {:demo, 'demo', '0.1.0'},
      {:plug_cowboy, 'A Plug adapter for Cowboy', '2.4.1'},
      {:cowboy_telemetry, 'Telemetry instrumentation for Cowboy', '0.3.1'},
      {:cowboy, 'Small, fast, modern HTTP server.', '2.8.0'},
      {:ranch, 'Socket acceptor pool for TCP protocols.', '1.7.1'},
      {:cowlib, 'Support library for manipulating Web protocols.', '2.9.1'},
      {:jason, 'A blazing fast JSON parser and generator in pure Elixir.\n', '1.2.2'},
      {:telemetry_poller,
       'Periodically collect measurements and dispatch them as Telemetry events.', '0.5.1'}
    ]
  end
end
