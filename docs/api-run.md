# build_with_docker _run_ API

Download and launch the app configured to be run by using Docker-Compose

## Type

Linux `make` shell commands

## Commands

Shell Command | Purpose
------------------- | -----
`make run`        | downloads and launches the app for default architecture (default is amd64 unless specified different in your `Makefile` file)
`make run-amd64`  | downloads and launches the app for amd64 architecture
`make run-arm64`  | downloads and launches the app for arm64 architecture
`make run-arm`    | downloads and launches the app for arm architecture

### Input parameters

Configure input parameters in `Makefile` and `bwd/run` directory

#### `Makefile`

In addition to [common parameters](api-broadparam.md) following _relevant_ parameters should/could be specified:

Param | Type | Short Description
---- | ---- | ----
`APPCONFIG` | String OPTIONAL | Name of the Docker Compose config file located in `bwd/run` directory. Default config file name is `<NAME>-<VERSION>.yml`
`RUN_PARAMS` | String OPTIONAL | Any extra `docker-compose up` parameters for starting an app. Default is `-d` which will start an app in backgound
`NETWORK` | String OPTIONAL | Docker network to create for the app to run on
`DOCKERC_CMD` | String OPTIONAL | Variation of Docker Compose client (default is `docker-compose`). The way to use, for example, `nvidia-docker-compose`
`PAUSE_FOR_ROSCORE` | String OPTIONAL | ROS apps only. Time to pause between roscore start and your app start. Default `2s`

#### `bwd/run` directory

Runtime configuration will be typically setup only for the top level repository of your project

`bwd/run` directory should be created and it should contain following Docker Compose configuration files:

~~~
├── bwd
│   ├── run                             # the folder which contains various run commands
│   │   ├── <NAME>-<VERSION>.yml        # default app's config file unless overriden by APPCONFIG variable
│   │   ├── roscore.yml                 # File to start roscore. Required only if it is ROS-based app
~~~

### Output

As a result of this command, your application will start
