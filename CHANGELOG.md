# 0.3.0

- Change entry format from Struct to a tuple list / Keyword

```elixir
[
  {:entry_name, "src/main.tsx"},
  {:css, "assets/main.aba08cbf.css"},
  {:module, "assets/main.aef2b0ab.js"},
  {:import_css, "assets/dynamic-import-polyfill.0f681641.css"},
  {:import_module, "assets/dynamic-import-polyfill.b75f6adf.js"},
  {:import_module, "assets/vendor.2c7f0e08.js"}
]
```

# 0.2.3

Somehow the version on Hex.pm for 0.2.2 has the 0.2.1 version in it. Bumping version to publish the correct one.

# 0.2.2

- `Vite.Manifest.get_css` returns an empty list, if CSS values are missing in the manifest (closes https://github.com/mindreframer/vite_phx/issues/1)
- `Vite.Manifest.from_raw` includes a default `[]` for missing `cssfiles`

# 0.2.1

- `Vite.react_refresh_snippet()` to enable hot-reload for React.js + documentation

# 0.2.0

- simpler integration into HTML templates
  - `Vite.vite_client()` for development
  - `Vite.vite_snippet(entry_point)`
- `Vite.inlined_phx_manifest()` to simplify accessing digested asset paths in JS
- `Vite.Cache` supports more than a single cache item

# 0.1.0

- Basic parsing for Vite manifests implemented
