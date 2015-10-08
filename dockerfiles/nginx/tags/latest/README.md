# Nginx Docker Image

* [![](https://badge.imagelayers.io/envygeeks/nginx:latest.svg)][latest] `latest`
[latest]:   https://imagelayers.io?images=envygeeks/nginx:latest

## Notes

* Add your extra configurations to /etc/nginx/conf.d/*.conf
* Add your sites to /etc/nginx/site.d/*.conf

If you need information on configuration of Nginx your Nginx instance please
visit http://nginx.org/en/docs/

## Running

```shell
docker run --name=nginx -p80:80/tcp \
  -v /srv/docker/volumes/nginx/etc/nginx/http:/etc/nginx/http \
  -dit envygeeks/nginx
```
