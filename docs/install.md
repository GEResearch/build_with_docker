# Install Build With Docker

`build_with_docker` should be installed as a git submodule of your project's
repo in the `bwd/src` subfolder

## Prerequisites for build_with_docker to function properly

Two prerequisites:

- Install Linux _make_ tool with `sudo apt-get install build-essential`
- Install and configure Docker and Docker-Compose.

## Install for your project

Install `build_with_docker` as a submodule for your project's repository:

~~~bash
$ mkdir bwd/
$ git submodule add git@github.com:GERobotics/build_with_docker.git bwd/src

### optional - If want to base on certain released version of build_with_docker:
$ cd build_with_docker
$ git reset --hard <build_with_docker ver>* 

... commit your repo including submodules here
~~~

> \* - `<build_with_docker ver>` is a version of build_with_docker you would like to use (see available releases at https://github.com/GERobotics/build_with_docker/releases). For example, `git reset --hard v1.0.0`

You can verify version of your `build_with_docker` submodule with following command:

~~~bash
$ git submodule status
~~~

Example output of this command is:

~~~
499f08b76f4599e900f09d4f9414f630f894c8ed build_with_docker (v1.0.0rc1)
~~~

## Cloning your project

Whenever your project's repo needs to be cloned ensure `--recursive` option. For example:

~~~bash
$ git clone --recursive <your repo>
~~~ 

This will bring down build_with_docker submodule along with other submodules you might have
