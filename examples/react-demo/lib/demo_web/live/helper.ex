defmodule DemoWeb.Live.Helper do
  # Use all HTML functionality (forms, tags, etc)
  use Phoenix.HTML

  # Import LiveView helpers (live_render, live_component, live_patch, etc)
  import Phoenix.LiveView.Helpers

  # Import basic rendering functionality (render, render_layout, etc)
  # import Phoenix.View
  # import DemoWeb.ErrorHelpers
  # import DemoWeb.Gettext
  # alias DemoWeb.Router.Helpers, as: Routes

  def a_helper() do
    assigns = %{:__changed__ => false, message: "FROM INSIDE"}

    ~L"""
    <p>
      MESSAGE: <%= @message %>
      SUBMESSAGE: <%= subhelper() %>
      <%= input_help("user1") %>
      <%= submit "Submit" %>
    </p>
    """
  end

  def subhelper() do
    assigns = %{:__changed__ => false, message: "FROM SUBHELPER"}

    ~L"""
    <p>
      MESSAGE: <%= @message %>
      <pre><%= inspect(Vite.Config.all(), pretty: true) %></pre>
    </p>
    """
  end

  def input_help(arg1) do
    tag(:input, type: "text", name: "user_id" <> arg1)
  end
end
