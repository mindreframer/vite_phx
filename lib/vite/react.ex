defmodule Vite.React do
  alias Vite.Config
  @doc """
  Inlined preamble from https://github.com/vitejs/vite/blob/main/packages/plugin-react-refresh/index.js#L24 to enable hot-reloading for React.js
  """
  def react_refresh_snippet do
    unless Vite.is_prod() do
      url = Path.join([Config.dev_server_address(), "@react-refresh"])
      {:safe, ~s[
        <!-- vendored from https://github.com/vitejs/vite/blob/main/packages/plugin-react-refresh/index.js#L24 -->
        <script type="module">
        import RefreshRuntime from "#{url}"
        RefreshRuntime.injectIntoGlobalHook(window)
        window.$RefreshReg$ = () => {}
        window.$RefreshSig$ = () => (type) => type
        window.__vite_plugin_react_preamble_installed__ = true
        </script>
      ] }
    end
  end
end
