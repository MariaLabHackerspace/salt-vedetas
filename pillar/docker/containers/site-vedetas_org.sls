{% import_yaml "docker/secret.sls" as secret %}

docker:
  compose:
    site-vedetas_org:
      container_name: 'site-vedetas_org'
      image: 'richarvey/nginx-php-fpm:latest'
      restart: 'always'
      links:
        - 'dbmysql:mysql'
      environment:
        VIRTUAL_HOST: 'vedetas.org,www.vedetas.org'
        VIRTUAL_PROTO: 'https' 
        VIRTUAL_PORT: 443
        CERT_NAME: 'vedetas.org'
      volumes:
        - '/srv/docker/nginx/www/vedetas.org/htdocs:/usr/share/nginx/html'
        - '/etc/letsencrypt:/etc/letsencrypt'
        - '/srv/docker/nginx/certs:/etc/nginx/certs'
        - '/srv/docker/nginx/sites-enabled:/etc/nginx/sites-enabled'
        - '/srv/docker/nginx/nginx-startup:/tmp/nginx-startup'
      command: '/tmp/nginx-startup/start.sh'

