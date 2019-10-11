# Build With Docker Getting Started

Build with Docker is a set of scripts designed to speed up consistent and easy-to-use development experience in order to:

- compile and cross-compile to non-native architectures
- run automated testing
- run code scanning/static code analysis
- create Unix packages
- create and publish buildtime and runtime Docker images for deployment
- run container-based apps for development purposes

Currently, it has been significantly tested on ROS-based components and apps, however, it is also capable of handling
any `cmake`-based projects
which makes this tool language independent to the most degree. It is also easy to extend it to any other Linux-based
frameworks

## API Reference

See this comprehensive [build_with_docker API documentation](api.md)
for details of each _make_ command


## Example app using `build_with_docker`

All repositories of the [`tutorial_app`](//github.com/GEResearch/template_app_ros)
(tutorial ROS app) have been fully instrumented with `build_with_docker`

## Step-by-Step Guide

### Build Steps

Follow these key development steps listed in the order they are usually performed:

**Step#1** - [Create your new GitHub repository](//help.github.com/enterprise/2.11/user/articles/create-a-repo/)

**Step#2** - [Install `build_with_docker`](install.md) into
your new repository. Key command:

~~~bash
$ mkdir bwd
$ git  submodule add git@github.com:GEResearch/build_with_docker.git bwd/src
$ mkdir bwd/config bwd/run  # Folder to hold project-specific bwd configuration & scripts
~~~

**Step#3** - Create a `Makefile` that should look like following minimal example:

~~~bash
NAME              = component_name
VERSION           = alpha_num_version

# Defines all build and run make targets provided by build_with_docker
include bwd/src/Makefile.in
~~~

**Step#4** - [Create Docker image for _development purposes_](api-buildimage.md)
(so called, builder image) and [shell into it](api-buildimage.md#start-and-shell-into-dev-image)
as needed to debug.
By Default, `make build-image` will build a Docker image defined by the Dockerfile
located in `bwd/config/Dockerfile.build`.

Example docker files can be found in the `example_dockerfiles` subfolder of the
`build_with_docker` repository.


Key commands:

~~~bash
$ make build-image        #build builder image

$ make build-shell        #enter into the builder container 1st time
$ make build-shellenter   #enter into the builder container subseq times
~~~

**Step#5** - [Compile your project](api-build.md) (uses builder image).
Key command:

~~~bash
$ make build
~~~

**Step#6** - If applicable, [Run tests for your project](api-test.md).
Key command:

~~~bash
$ make test
~~~

**Step#7** - If applicable, run code scan.
Key command:

~~~bash
$ make scan
~~~

**Step#8** - If applicable, [Create Debian package](api-package.md).
Key command:

~~~bash
$ make package
~~~

**Step#9** - If applicable, [Create Docker image for _running_ your app](api-image.md).
Key command:

~~~bash
$ make image
~~~

**Step#10** - If applicable, [publish your Docker images](api-push.md) to
docker hub or a Docker Trusted Registry (DTR) for deployment.

~~~bash
$ make push
~~~

**Step#12** - If applicable, [configure launch file(s) of your app](api-run.md#mt_run-directory).
Docker Compose-compatible file(s) should be provided.


### Run Steps

You can [download, start, log and stop your app](api.md#run-apis)
for development purposes using `build_with_docker`. Key commands:

~~~bash
$ make pull
$ make run
$ make logs
$ make stop
~~~
