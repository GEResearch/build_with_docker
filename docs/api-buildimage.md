# build_with_docker _build-image_ API 
 
Build and run a Docker image for development purposes (aka "builder" image)

## Type

Linux `make` shell commands

## Command variations

### Build dev image

Shell Command | Purpose
------------------- | -----
`make build-image`        | build a Docker image for development purposes for default architecture (default is amd64 unless specified different in your `Makefile` file)
`make build-image-amd64`  | build a Docker image for development purposes for amd64 architecture
`make build-image-arm64`  | build a Docker image for development purposes for arm64 architecture
`make build-image-arm`    | build a Docker image for development purposes for arm architecture

### Start and shell into dev image

Shell Command | Purpose
------------------- | -----
`make build-shell`        | starts & shells into a development Docker image for default architecture (default is amd64 unless specified different in your `Makefile` file)
`make build-shell-amd64`  | starts & shells into a development Docker image for development purposes for amd64 architecture
`make build-shell-arm64`  | starts & shells into a development Docker image for development purposes for arm64 architecture
`make build-shell-arm`    | starts & shells into a development Docker image for development purposes for arm architecture

Shell Command | Purpose
------------------- | -----
`make build-shellenter`        | shells into a previously created development Docker container 
`make build-shellenter-amd64`  | shells into a previously created development Docker container 
`make build-shellenter-arm64`  | shells into a previously created development Docker container
`make build-shellenter-arm`    | shells into a previously created development Docker container


`build-shellenter` is basically a way to get into the same development container with multiple shells easily. 

For example, you might want to start you system with `roslaunch` in the first shell (started with `build-shell`) and then run `rviz` in another shell 
of the same container which you enter with `build-shellenter`


### Cross-compiling notes

See [build API](api-build.md)

### Input parameters

Configure input parameters in `Makefile` and `bwd/config/Dockerfile.build` (or other path overriden by var `BUILDER_DOCKERFILE` - see below)

#### `Makefile`

In addition to [common parameters](api-broadparam.md) following _relevant_ parameters should/could be specified for `make build-image` commands:

Param | Type | Short Description
---- | ---- | ----
`BUILDER_BASEIMAGE`  | String REQUIRED | Base image for your development image _required_ for _non-ROS_ projects. Substitutes `ARG_FROM` in your `Dockerfile.build`
`BUILDER_BASEIMAGE`  | String OPTIONAL | Base image for your development image _optional_ for _ROS_ projects with default `$(REGISTRY)/bp-ros-desktop-full-amd64:$(ROS_DIST_VER)` for amd64 architecture
`BUILDER_IMAGE_PARAMS`  | String OPTIONAL | Any extra `docker build` parameters when creating this dev images
`REGISTRY`   | String OPTIONAL | Docker registry URL which will be added to the name of the resulting image. This URL determines location where the image will be stored. This must be set if you want to be able to push or pull from dockerhub or a docker trusted registry.
`BUILDER_DOCKERFILE` |  String OPTIONAL | Path to the Dockerfile which will be used for building this builder image. Default is `bwd/config/Dockerfile.build`

_Relevant_ parameters could be specified for `make build-shell` commands:

Param | Type | Short Description
---- | ---- | ----
`BUILDER_SHELL_PARAMS`  | String OPTIONAL | Any extra `docker run` parameters when shelling into this dev images 
`BUILDER_ENABLE_GUI`  |  String OPTIONAL | Adds special configuration to `BUILDER_SHELL_PARAMS` to enable Linux GUI rendering out of the container

_Relevant_ parameters could be specified for `make build-shellenter` commands:

Param | Type | Short Description
---- | ---- | ----
`BUILDER_ENTER_PARAMS`  | String OPTIONAL | Any extra `docker run` parameters when shelling into this dev image.
`BUILDER_ENABLE_GUI`  |  String OPTIONAL | Adds special configuration to `BUILDER_ENTER_PARAMS` to enable Linux GUI rendering out of the container

#### `bwd/config/Dockerfile.build`

Following parameters can be specified in `Dockerfile.build` and will be automatically substituted:

Param | Type | Short Description
---- | ---- | ----
`ARG_FROM` | String | Name of the base image for target dev image. Will be replaced by `BUILDER_BASEIMAGE` variable from `Makefile`
`ARG_NAME` | String | Name of the target app - will be replaced by `NAME` variable from `Makefile`
`ARG_ARCH` | String | Architecture of the target app - will be replaced by `ARCH` variable from `Makefile`


### Output

Type | Short Description
---- | ----
Docker image | Builder image `<REGISTRY>/<NAME>-builder-<ARCH>:<VERSION>` created based on the `Dockerfile.build`











