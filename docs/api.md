# _build_with_docker_ APIs

Set of available _make_ commands and scripts to compile, test, package and run your project

## Type

Linux `make` commands

## Development APIs 

API/command | Purpose
---- | -----
[make info](api-info.md)      | evaluates and shows values of key parameters defined in `Makefile -> Makefile.in` 
[make build-image](api-buildimage.md) | creates Docker image for development purposes (aka "builder" image)
[make build-shell](api-buildimage.md) & [make build-shellenter](api-buildimage.md) | creates and shells into builder image for development purposes
make build-push  | publishes builder image to DTR in case it needs to be shared with others
[make build](api-build.md)      | builds binaries within the builder image 
[make test](api-test.md)       | runs unit tests & mocks within the builder image 
[make package](api-package.md)    | builds Debian package within the builder image 
make scan    | runs static code analysis of your code within the builder image. Only hooks provided today (i.e. `SCAN_SCRIPT` variable) so each project needs to provide its scanning
[make image](api-image.md)      | builds runtime Docker image
[make push](api-push.md)       | publishes runtime image to DTR
[make all-build](api-build.md)  | `make build` for all supported architectures
[make all-package](api-package.md)| `make package` for all supported architectures
[make all-image](api-image.md) | `make image` for all supported architectures
[make all-push](api-push.md)   | `make push` for all supported architectures
make clean-all      | removes all build artifacts and images (builder and runtime)
make clean  | removes only build artifacts (i.e. no images are removed)

## Run APIs


API/command | Purpose
---- | -----
[make run](api-run.md)        | downloads and launches the app
make pull        | downloads the app without starting an app based on the configuration of `make run` command
make stop        | stops the app that was started by `make run`
make logs        | shows logs of the app that was started by `make run`

**Notes:**
- These tools are primarily provided for development purposes
- For deployment, Docker Compose, Docker Machine, etc is recommended.
