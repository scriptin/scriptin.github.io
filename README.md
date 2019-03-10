# My personal site

## Building Docker image and starting container

    # Build image:
    $ docker build --rm --tag=site .

    # List all images to get the IMAGE_ID
    $ docker images

    # Start new container, attaching sources from current directory and forwarding port 4000
    $ docker run -it -v "$PWD:/src" -p 4000:4000 IMAGE_ID

Then go to `http://localhost:4000`.

Use `Ctrl+P Ctrl+Q` to detach from container's tty.

## Refreshing CSS files

Inside the container run `./update_css.sh`
