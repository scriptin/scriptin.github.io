# My personal blog

## Testing locally

1. Install [Devbox](https://www.jetpack.io/devbox/)
2. Run `devbox run serve`

Then go to `http://localhost:4000`. Port `35729` is used for live reloading.

## Refreshing CSS

1. Install [Devbox](https://www.jetpack.io/devbox/)
2. Run `devbox run styles:watch` - this will also rebuild the existing styles if they've changed
3. Run (in a separate terminal) `devbox run cv:watch` to rebuild Typst files
