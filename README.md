# tmux-static-builder

Simple container to build a staticly linked tmux binary.

## Use

```shell
# Build the image to compile the binary (running `make` will do so)
$ make

# Alternatively you can run it manually with Podman (or Docker)
$ podman build -t tmux-static-builder .
```

```txt
# Within a Containerfile (or Dockerfile), 
# Copy the binary from the resulting image in a staged build

COPY --from=localhost/tmux-static-builder:latest /tmux /usr/bin/tmux
```

## Acknowledgements

Thanks to:

    zenofile (https://github.com/zenofile) for the Gist used to build the static binary inside the container.

