# Scratch `recipe`.

To use the scratch recipe create a dockerfile folder with your base image and then symlink to the `recipe` file in this folder.  When you have done that use the below to guide you, however the best directions might be the source and `dockerfiles/{alpine,ubuntu}`

## `copy/rootfs/usr/local/bin/mkimg`

This script should be provided to the `rootfs` (rootfs is automatically provided by scratch through the `recipe`.  You just need make sure `mkimg` exists.) From `mkimg` we will build a `rootfs` builder that will run `mkimg` across multiple builds and save the resultng `rootfs.tar.gz` which will be pushed into the scratch image.  Any data you wish to get pushed onto the main image should be saved to a directory and `tar.gz`'d onto `$archive` (a blank file provided and mounted.)

### Why the usage of `$archive`?

https://github.com/docker/docker/issues/15777: if we push the tar.gz archive onto `1` like some other base images do we could end up screwing something up and creating a bad image, this is not ideal, so instead of saying `>&2` everything, we will mount a file that you write to and that's what we will use, this makes it so you don't need to work around me and just need to get shit done.

This file is not reused and it has a unique name each time, and is empty so please make sure you write to `$archive` instead of using your own file name or saving the file name for future use.

## Default files and folders in `opt/`

* dir: `pkgs` - holds the default packages for each `repo, tag, type`.
* file: `imgs` - the images you wish to build, format: `repo:tag/type` no user.
* file: `entries`  - provides all the entrypoints precedence: `repo, tag, type`
* file: Any other file directory you want, it's mounted into `$opt`

It should be noted that for `pkgs`, all of the above are installed, so if you have a pkg file for repo and one for tag, both the packages from repo and tag will be installed and then on down the line, in that order.  There is also a `all` package type which is a global package incase you have multiple types and tags and so forth.  ***It should also be noted, that this builder has no concept of aliases so all that you do will result in a unique image.***

## Environment variables

* `$opt`:`readonly`: the `opt/` folder in the dockerfile folder.
* `$common`:`readonly`: the `common/` folder from the root of the git repo.
* `$cache`: the cache folder used to cache things like downloads.
* `$archive`: The file you should push your tgz rootfs file to.
* `$copy`:`readonly`: The copy folder from the the dockerfile folder.

### Environment variables to access variables?

Yes, to make sure there are no clashed file names we `mktemp -u` several names and then mount as those names inside of the image and pass those folders as env vars so that you can get to those folders, this tries to guarantee that you can do whatever you want without us getting in the way.

## Notes to make things easier

* Unlike other things entries does not allow multiple entries.
* Use cache wisely, it's stored on the host file system, so remember it.
* Common is global, don't put image specific assets there.
