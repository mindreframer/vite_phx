# Demo Phoenix + Vite.js assets with static files (images/fonts) deployed to Heroku

Showcase for a working deployable Phoenix application where assets are managed with Vite.js. Uses [vite_phx](https://github.com/mindreframer/vite_phx) for intergration with Phoenix.

URL: https://vite-phoenix.herokuapp.com/

### Setup + boot

```
$ mix setup
$ bin/install_overmind # confirm with `return` or `y`
$ bin/overmind s
```

### HEROKU DEPLOYMENT

- https://hexdocs.pm/phoenix/heroku.html

```
$ heroku buildpacks:add https://github.com/gjaldon/heroku-buildpack-phoenix-static.git
$ heroku buildpacks:set hashnuke/elixir
$ heroku buildpacks:add https://github.com/gjaldon/heroku-buildpack-phoenix-static.git
```
