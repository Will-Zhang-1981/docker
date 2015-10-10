# EnvyGeeks Docker Images

[![Build Status](https://travis-ci.org/envygeeks/docker.svg?branch=master)][travis]
[travis]: https://travis-ci.org/envygeeks/docker

Here you will find all of the Docker images that I currently use, support,
update and work with for both clients and open source projects.  You can see a
current list of images by checking out the `dockerfiles` directory.

## Building images

* Build all images with: `script/build`
* Build a specific image and it's tags with `script/build repo`
* Build a specific image tag with `script/build repo:tag`

## Customizing the user that owns the image

* Default: `script/build -u user repo:tag`
* Docker style: `script/build user/repo:tag`
