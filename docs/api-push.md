# build_with_docker _push_ API

Publish runtime Docker image to DTR (i.e. Docker images repository)

## Type

Linux `make` shell commands

## Commands

Shell Command | Purpose
------------------- | -----
`make push`        | Publish runtime Docker image for default architecture (default is amd64 unless specified different in your `Makefile` file)
`make push-amd64`  | Publish runtime Docker image for amd64 architecture
`make push-arm64`  | Publish runtime Docker image for arm64 architecture
`make push-arm`    | Publish runtime Docker image for arm architecture
`make all-push`    | Publish runtime Docker image for all architectures

### Input parameters

See [image API](api-image.md) for what images will be published

### Output

Type | Short Description
---- | ----
Docker image | Docker image stored in the Docker registry and organization specified by `REGISTRY` variable

## Support Information

By default, images will be stored in Docker Hub. This can be overridden to use a Docker Trusted Registry by using the `REGISTRY` variable.

Note a free account will be needed on dockerhub.
