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
