# My personal site

## Building a Docker image and starting a container

    # Build image:
    $ docker build --rm --tag=site .

    # Start a new container, attaching sources from current directory and forwarding port 4000
    $ docker run -it -v "$PWD:/src" -p 4000:4000 -p 35729:35729 --name site site

Then go to `http://localhost:4000`.

Use `Ctrl+P Ctrl+Q` to detach from container's tty or `Ctrl+C` to stop a container.

## Refreshing CSS

Inside the container run `./update_css.sh`:

    $ docker exec site "./update_css.sh"
