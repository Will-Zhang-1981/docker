# EnvyGeeks Docker Images

[![Build Status](https://travis-ci.org/envygeeks/docker.svg?branch=master)](https://travis-ci.org/envygeeks/docker)

Here you will find all of the Docker images that I currently use, support,
update and work with for both clients and open source projects.  You can see a
current list of images by checking out the `dockerfiles` directory.

## Building images

You can build all repos by doing `script/build repo` and if you wish to build a specific tag of a repo you can do `script/build repo:tag`

# Adding your own Docker images

If you fork this repo and wish to add your own Docker image, or wish to submit a
recipe for a Docker image than you can do so by following the guide below.

Examples of each type:

* dockerfiles/alpine: scratch
* dockerfiles/jekyll: templated
* dockerfiles/ubuntu: scratch
* dockerfiles/\*: normal

## Repo types

There are 3 repo types, those that have templated Dockerfiles for tags, those
that have a a set of tags defined for a scratch image, and those that are just
simple images that don't have anything special other than a basic Dockerfile.
Most are of the simple kind.

### Templated Dockerfiles: `tags/*`

The `dockerfiles/jekyll` folder is a classic example of a templated Docker
repository with many tags.  This is done so that you can have automated builds
but different Dockerfiles and setups for each type, for example if you have tags
that each require a different version of something.  In this scenario there is
no special build file required but you should probably maintain a sync script
to create the `tags/` and all of the sub-folder that hold all of the parsed
`Dockerfiles`, `README.md`'s and any copy data.

You should also probably maintain a `script/build` file that will sync
automatically before building all of the images, the `script/build` file in the
root of this folder will not do that on your behalf

### Scratch Images: `options/tags`

These types of images are generally reserved for ultra base scratch images that
use the `scratch` builder to build a base `rootfs` with `mkimg` that is ran to
setup multiple different types (tags) of the base.  Both `ubuntu` and `alpine`
are this type of repository.

For this type of repository you will create an `options/tags` file that has
all of the tags and their types, alias `script/build` to `vendor/scratch/build`
and then setup copy folders... multiple copy folders.

#### `copy/usr/local/bin/mkimg` and `rootfs`

When you build your images a base `rootfs` will be built and this base rootfs is
what will actually build and output the data for your scratch image.  You can
see `dockerfiles/alpine/copy/rootfs/*/mkimg` for an example of how
to use that file to build the data for your scratch image.

This script can do anything you want it to do, including what we do where we
detect types and other stuff to install packages for specific tags, but the
end-goal of this file is to write to `$ARCHIVE_TAR` with the tar data to be
shoved into the scratch image.

#### Image types

You define the types (via `options/entries`,) they are liquid in that we don't
have any set types or anything, you define the types, normally we have the base
type `normal` a nd a few other types like `dev` and `tiny`.  Types exist solely
so you can adjust the behavior of `mkimg` and so that you can install packages
and other stuff based on not just the repo, but also the the tag and type, fluid
images.

#### `options/entries` file

The `options/entries` file holds entrypoints for your scratch image, this goes
in a specific order of importance: tag, type, repo.  So if you want the tag
`iojs` to entrypoint to `/usr/bin/iojs` then you would add `iojs /usr/bin/iojs`
and that will be the entrypoint for that tag, you can also do that for the type
and even repo.

#### `options/tags` file

```
tag/type
tag/type
```

#### `copy/*` folders

The `vendor/common` folder is also mounted. For you to copy first and foremost,
it is the base copy but it's common to everything in the base images, this sits
in the root of this repository.  There are also other types of copy folders:

* `copy/type`
* `copy/repo`
* `copy/tag`

#### `cache/` folder

You can create a `cache` folder in the repo which can store data you want to
persist and maintain across every build, a good example of this is how we store
the cloud image of Ubuntu for the Ubuntu base image.

#### Variables

The following variables are meant to be used in
`copy/rootfs/usr/local/bin/mkimg`

* `$CI`: Whether or not you are on a CI.
* `$TRAVIS`: Whether or not you are on Travis-CI.
* `$DEBUG`: Whether or not the user wants verbose output.
* `$CACHE_DIR`: The temporary directory pointing to `cache/`.
* `$ARCHIVE_TAR`: The temporary file you write your final image to.
* `$COMMON_DIR`: The temporary directory pointing to `vendor/common`
* `$OPTIONS_DIR`: The temporary directory pointing to `options/`.
* `$COPY_TYPE_DIR`: The `copy/*` directory for the tag type.
* `$COPY_REPO_DIR`: The `copy/*` directory for the repo.
* `$COPY_TAG_DIR`: The `copy/*` directory for the tag.
* `RELEASE`: The release you set in releases/$tag|$type|all.
* `USER`: The user it's being built on.
* `REPO`: The repo name.
* `TYPE`: The tag type.
* `TAG`: The tag.
