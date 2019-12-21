# Docker Container with Nginx, Certbot and the Certbot Nginx Plugin 

Docker container that runs [Nginx](https://nginx.org) and requests and installs letsencrypt https certificates through [Certbot](https://certbot.eff.org).

This is mainly just the [upstream Nginx Alpine container](https://hub.docker.com/_/nginx) but runs the simple script in [./command](./command) that requests and installs a certificate through the  [Certbot Nginx plugin](https://pypi.org/project/certbot-nginx/) (a.k.a `certbot --nginx`) if you set variables:

```
RUN_CERTBOT=true
CERTBOT_DOMAINS=example.com,www.example.com
CERTBOT_EMAIL=you@example.com
```

This is inspired by/partially copied from [staticfloat/docker-nginx-certbot](https://github.com/staticfloat/docker-nginx-certbot) but scripting is vastly simplified by just relying on `cerbot --nginx`.

## Usage

In a development/testing environment you can simply leave `RUN_CERTBOT` unset or `RUN_CERTBOT=false` and you can test your Nginx config without https locally. 

The script in the container will attempt certificate renewal every 7 days.

### Docker

```
docker run -e 'RUN_CERTBOT=true' -e 'CERTBOT_DOMAINS=example.com,www.example.com' -e 'CERTBOT_EMAIL=you@example.com' kitspace/nginx-certbot-plugin
```

### Docker Compose

```yaml
services:
  nginx:
    image: kitspace/nginx-certbot-plugin 
    environment:
      - RUN_CERTBOT=true
      - CERTBOT_DOMAINS=example.com,www.example.com
      - CERTBOT_EMAIL=you@example.com
```
  
