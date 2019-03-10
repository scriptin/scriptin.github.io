# My personal site

## Building a Docker image and starting a container

    # Build image:
    $ docker build --rm --tag=site .

    # Start a new container, attaching sources from current directory and forwarding port 4000
    $ docker run -it -v "$PWD:/src" -p 4000:4000 site

Then go to `http://localhost:4000`.

Use `Ctrl+P Ctrl+Q` to detach from container's tty or `Ctrl+C` to stop a container.

## Refreshing CSS

Inside the container run `./update_css.sh`:

    # Get a container name/id
    $ docker ps

    # Run a script to update CSS
    $ docker exec {CONTAINER_ID} "./update_css.sh"
