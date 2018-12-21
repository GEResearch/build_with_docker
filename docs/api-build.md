# build_with_docker _build_ API

Builds target binaries or performs other build-related actions within the builder image

## Type

Linux `make` shell commands

## Commands

Shell Command | Purpose
------------------- | -----
`make build`        | build target artifacts for default architecture (default is amd64 unless specified different in your `Makefile` file)
`make build-amd64`  | build target artifacts for amd64 architecture
`make build-arm64`  | build target artifacts for arm64 architecture
`make build-arm`    | build target artifacts for arm architecture
`make all-build`    | target artifacts for all architectures

### Input parameters

Configure input parameters in `Makefile` and `bwd/config` directory (optional)

#### `Makefile`

In addition to [common parameters](api-broadparam.md) following _relevant_ parameters could be specified:

Param | Type | Short Description
---- | ---- | ----
`BUILD_PARAMS`  | String OPTIONAL | Any extra `docker run` parameters when building within the builder image
`ROS_DIST_VER` | String OPTIONAL | ROS version - `indigo` or `kinetic` (default is `kinetic`). Relevant only if compiling ROS code
`BUILD_SCRIPT` | String OPTIONAL | Script that performs the build within the builder image. Default is `./bwd/src/provision_container.sh bwd/src/build-ros.sh` for ROS projects and `./bwd/src/provision_container.sh bwd/src/build.sh` for non-ROS

#### Guidance on Build Script(s)

Default build script (i.e. specified with `BUILD_SCRIPT`) makes assumptions of the type of the project (i.e. cmake) and
how the repo is structured (see How-to-Use guides about the structure).

However, in order to fit your project type and repo structure this behaviour can be easily overriden by creating your own build script(s) and
providing its path in `BUILD_SCRIPT`.

In this case, we still recommend to use `./bwd/src/provision_container.sh` to run your script because it provisions builder image with
current userid instead of running everything as root within the container

### Output

Type | Short Description
---- | ----
Target artifacts | Compiled libraries or executables stored in `bin/<ARCH>` directory

## Prerequisites for cross-compiling

To be able to compile on non-native architecture (i.e. cross-compile), it is necessary to install and comfigure QEMU on the host PC.

For example, ussual scenario is to build arm or arm64 on amd64/Intel-based PC

```shell
$ sudo apt-get update && sudo apt-get install qemu-user-static binfmt-support

$ sudo update-binfmts --enable  qemu-arm        #enable arm   emulation
$ sudo update-binfmts --enable  qemu-aarch64    #enable arm64 emulation
```

**More info**
>Good sources of details are:
>- http://blog.ubergarm.com/run-arm-docker-images-on-x86_64-hosts/
>- https://resin.io/blog/building-arm-containers-on-any-x86-machine-even-dockerhub/









