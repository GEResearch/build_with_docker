# build_with_docker _package_ API

Builds a Debian package within the builder image.

## Type

Linux `make` shell commands

## Commands

Shell Command | Purpose
------------------- | -----
`make package`        | build a Debian package for default architecture (default is amd64 unless specified different in your `Makefile` file)
`make package-amd64`  | build a Debian package for amd64 architecture
`make package-arm64`  | build a Debian package for arm64 architecture
`make package-arm`    | build a Debian package for arm architecture
`make all-package`    | build a Debian package for all architectures

**Cross-compiling notes:** see [build API](api-build.md)

### Input parameters

Configure input parameters in `Makefile` and `bwd/config` directory (optional)

#### `Makefile`

In addition to [common parameters](api-broadparam.md) following _relevant_ parameters could be specified:

Param | Type | Short Description
---- | ---- | ----
`PACKAGE_PARAMS`  | String OPTIONAL | Any extra `docker run` parameters when creating Debian packages withing builder image
`ROS_DIST_VER` | String OPTIONAL | ROS version - `indigo` or `kinetic` (default is `kinetic`). Relevant only if compiling ROS code
`PACKAGE_SCRIPT` | String OPTIONAL | Script that creates Deb packages within the builder image. Default is `./bwd/src/provision_container.sh bwd/src/package-ros.sh` for ROS projects and `./bwd/src/provision_container.sh bwd/src/package.sh` for non-ROS

#### Guidance on Packaging Script

In addition to the guidance in [make build API](api-build.md), note that Debian packaging is available "out-of-the-box" for the ROS projects
with `bwd/src/package-ros.sh` based on bloom tool and packages.xml metadata for each ROS package

However, for non-ROS projects, for now, only hook is provided and therefore packaging script needs to be written for each individual project


### Output data

Type | Short Description
 ---- | ----
A Debian package per ROS package| Output is stored in `bin/<ARCH>` directory as below:

Generated artifacts shown as below:
~~~
└── <ARCH>
    ├── src
    │   ├── ros-<ROS_DIST_VER>-<NAME>_<VERSION>-0<OS_VERSION>_<ARCH>.changes
    │   ├── ros-<ROS_DIST_VER>-<NAME>_<VERSION>-0<OS_VERSION>_<ARCH>.deb
    │   └── ros-<ROS_DIST_VER>-<NAME>_<VERSION>.orig.tar.gz
~~~
