# build_with_docker _test_ API

Compile and run automated tests within the builder image

## Type

Linux `make` shell commands

## Commands

Shell Command | Purpose
------------------- | -----
`make test`        | compile & run tests for default architecture (default is amd64 unless specified different in your `Makefile` file)
`make test-amd64`  | compile & run tests for amd64 architecture
`make test-arm64`  | compile & run tests for arm64 architecture
`make test-arm`    | compile & run tests for arm architecture

**Cross-compiling notes:** see [build API](api-build.md)

### Input parameters

Configure input parameters in `Makefile` and `bwd/config` directory (optional)

#### `Makefile`

In addition to [common parameters](api-broadparam.md) following _relevant_ parameters could be specified:

Param | Type | Short Description
---- | ---- | ----
`TEST_PARAMS`  | String OPTIONAL | Any extra `docker run` parameters when running tests withing builder image
`ROS_DIST_VER` | String OPTIONAL | ROS version - `indigo` or `kinetic` (default is `kinetic`). Relevant only if compiling ROS code
`TEST_SCRIPT` | String OPTIONAL | Script that performs tests within the builder image. Default is `./bwd/src/provision_container.sh bwd/src/test-ros.sh` for ROS projects and `./bwd/src/provision_container.sh bwd/src/test.sh` for non-ROS

#### Guidance on Test Script

See [make build API](api-build.md) for similar guidance

### Output

Output | Short Description
---- | ----
Binary executable tests | If applicable, compiled binary executable tests stored in `bin/<ARCH>` directory
Test results | If testing ROS code, test results stored in `bin/<ARCH>//build/<NAME>/test_results/<NAME>/rosunit-test_<NAME>.xml`

