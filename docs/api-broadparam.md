# General applicability parameters for all build_with_docker APIs
 
Following parameters are applicable to all APIs provided by build_with_docker's Makefile.in

Param | Type | Short Description
---- | ---- | ----
`NAME` | String REQUIRED | Base name for naming compiled binaries and images
`VERSION` | String REQUIRED | Version of resulting compiled binaries and images
`ARCH`    | String OPTIONAL | What CPU arch to build for. Default is `amd64` (Intel) arch
`DOCKER_CMD` | String OPTIONAL | Variation of Docker client (default is `docker`). The way to use, for example, `nvidia-docker`
`IS_ROS` | String `yes/no` OPTIONAL | Default is `no`. If `yes` then extra conviniences will be automatically provided for ROS-type of projects
