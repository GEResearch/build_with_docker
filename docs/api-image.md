# build_with_docker _image_ API 
 
Build runtime Docker image 

## Type

Linux `make` shell commands

## Commands

Shell Command | Purpose
------------------- | -----
`make image`        | build runtime Docker image for default architecture (default is amd64 unless specified different in your `Makefile` file)
`make image-amd64`  | build runtime Docker image for amd64 architecture
`make image-arm64`  | build runtime Docker image for arm64 architecture
`make image-arm`    | build runtime Docker image for arm architecture
`make all-image`    | build runtime Docker image for all architectures 

**Cross-compiling notes:** see [build API](api-build.md)

### Input parameters

Configure input parameters in `Makefile` and `bwd/config` directory

#### `Makefile`

In addition to [common parameters](api-broadparam.md) following _relevant_ parameters should/could be specified:

Param | Type | Short Description
---- | ---- | ----
`RUN_BASEIMAGE`  | String REQUIRED | Base image for your runtime image _required_ for _non-ROS_ projects. Substitutes `ARG_FROM` in your `Dockerfile.build`
`RUN_BASEIMAGE`  | String OPTIONAL | Base image for your runtime image _optional_ for _ROS_ projects with default `ros:$(ROS_DIST_VER)-ros-core` for amd64 architecture
`RUN_IMAGE_PARAMS`  | String OPTIONAL | Any extra `docker build` parameters when creating this runtime image
`REGISTRY`   | String OPTIONAL | Docker registry URL which will be added to the name of the resulting image. This URL determines location where the image will be stored. This must be set if you want to be able to push or pull from dockerhub or a docker trusted registry.
`RUN_DOCKERFILE` |  String OPTIONAL | Path to the Dockerfile which will be used for building this runtime image. Default is `bwd/config/Dockerfile.run`

#### `bwd/config` directory

By default, `Dockerfile.run` file needs to be present in `bwd/config` directory

Following parameters can be specified in `Dockerfile.run` file and they will be automatically substituted:

Param | Type | Short Description
---- | ---- | ----
`ARG_FROM` | String | Name of the base image of the target  image. Will be replaced by `RUN_BASEIMAGE` variable from `Makefile`
`ARG_NAME` | String | Name of the target app - will be replaced by `NAME` variable from `Makefile`
`ARG_ARCH` | String | Architecture of the target app - will be replaced by `ARCH` variable from `Makefile`

### Output

Type | Short Description
---- | ----
Docker image | Runtime Docker image `<REGISTRY>/<NAME>-<ARCH>:<VERSION>` based on the `Dockerfile.run`

