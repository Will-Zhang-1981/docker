***Repository:*** https://github.com/envygeeks/docker/tree/master/repos/ubuntu
# Ubuntu Docker Image
## Differences between "official" and this image.

* `docker-helper` command with tons of useful tools.
* Helpers setup and installed in `/usr/local/share/docker`
* Cleaned out filesystem removing unneeded files.

## Pre-Service Startup

You can run tasks before any services startup by placing your pre-service startup scripts inside of `/etc/startup1.d`, these scripts *need to exit* and they should probably use `-e` so they trip the entire process if something goes wrong.  These scripts are meant for you to do tasks on startup that don't necessarily require a service.

These types of things are meant to simplify your startup files by allowing you to default tasks like fixing permissions, bundling or migrating and anything you wish to do in-between.

## Services

You should add your image services to `/etc/startup3.d`.  `/etc/startup2.d` is reserved for the this image specifically and `/etc/startup3.d` is reserved for any services that your image might provide.

These services are started with runit so you should do something like `/etc/startup3.d/service/{run,finish}` where `run` is what starts your service (it should stay in the foreground) and `finish` is the script ran to cleanup. *You do not need to have a finish script, that is optional!*

A basic `/etc/startup3.d/<service>/run`

```shell
#!/bin/sh
exec binary
```

## Startup and Shutdown folders.

* *shutdown.d*: One-off scripts that *should exit*, ran before service shutdown.
* *startup1.d*: One-off scripts that *should exit*, ran before service startups.
* *startup2.d*: Services for the golden image (this image.)
* *startup3.d*: Services for your image (the image using this image.)

## Helpers

There is a set of helpers that all the images come with, they are accessible via `docker-helper` (in the image) or by sourcing `/usr/local/share/docker/helpers`, a current list of these helpers is:

* cleanup
* download $url
* operating_system
* testsha $file $sha
* enable_stdout_logger
* cookie_dl $url $cookie
* create_log $user:$user $log_file
* create_dir $user:$user $dir $permissions
* install_user_pkgs_from_file
* reset_user(s) $user:$id
* user_pkg_installer_ran
* install_from_apk_file
* install_from_apt_file
* user_pkgs_installed
* ruby_install_gem $gem
* add_gemfile_dependency $gem
* copy_default_gems_to_gemfile $gem
* git_clone_ruby_repo $repo
* install_default_gems
* has_previous_gemfile
* install_users_gems
* backup_gemfile

### Gem Examples

We use a custom format for both Git repos and Gems that allows us to do things kind of cleanly, it's an easy syntax:

```
gem@version,https://github.com:user/repo.git@branch
gem@version,git://github.com:user/repo.git@branch
gem@version,user/repo@branch
gem@version
gem
```
