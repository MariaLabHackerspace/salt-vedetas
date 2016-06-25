{% import_yaml "docker/secret.sls" as secret %}

docker:
  compose:
    site-f3mhack_org:
      container_name: 'site-f3mhack_org'
      image: 'richarvey/nginx-php-fpm:latest'
      restart: 'always'
      links:
        - 'dbmysql:mysql'
      environment:
        VIRTUAL_HOST: 'f3mhack.org,www.f3mhack.org,femhack.org,www.femhack.org'
        VIRTUAL_PROTO: 'https'
        VIRTUAL_PORT: 443
        CERT_NAME: 'f3mhack.org'
      volumes:
        - '/srv/docker/nginx/www/f3mhack.org/htdocs:/usr/share/nginx/html'
        - '/etc/letsencrypt:/etc/letsencrypt'
        - '/srv/docker/nginx/certs:/etc/nginx/certs'
        - '/srv/docker/nginx/sites-enabled_f3mhack.org:/etc/nginx/sites-enabled'
        - '/srv/docker/nginx/nginx-startup:/tmp/nginx-startup'
      command: '/tmp/nginx-startup/start.sh'

