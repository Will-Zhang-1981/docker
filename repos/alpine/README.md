***Repository:*** https://github.com/envygeeks/docker/tree/master/repos/alpine

# Alpine Docker Images

* OpenRC replaced with Runit (in it's entirety.)
* Helpers setup and installed in `/usr/local/share/docker`
* `docker-helper` command with tons of useful tools.
* Cleaned out filesystem removing unneeded files.

## Startup and Shutdown folders.

* *shutdown.d*: One-off scripts that *should exit* ran before service shutdown.
* *startup1.d*: One-off scripts that *should exit* ran before service startups.
* *startup2.d*: Services for the golden image (this image.)
* *startup3.d*: Services for your image (the image using this image.)
