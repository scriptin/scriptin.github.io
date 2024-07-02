# My personal blog

## Testing locally

1. Install [Devbox](https://www.jetpack.io/devbox/)
2. Run `devbox run serve`

Then go to `http://localhost:4000`. Port `35729` is used for live reloading.

## Refreshing CSS

1. Install [Devbox](https://www.jetpack.io/devbox/)
2. Run `devbox run styles:watch` (or `devbox run styles:build` for production)

Note that CSS files may be cached, so during development it is recommended to keep DevTools open
with the 'Disable cache' checkbox set oin the Network tab.
