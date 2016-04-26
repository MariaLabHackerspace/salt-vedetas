{% import_yaml "docker/secret.sls" as secret %}

docker:
  compose:
    site-vedetas_org:
      container_name: 'site-vedetas_org'
      image: 'richarvey/nginx-php-fpm:latest'
      restart: 'always'
      links:
        - 'mailserver_mail_1:mail'
      ports:
        - '80:80'
        - '443:443'
      environment:
        VIRTUAL_HOST: 'vedetas.org'
      volumes:
        - '/srv/docker/nginx/www/vedetas.org/htdocs:/usr/share/nginx/html'
        - '/etc/letsencrypt:/etc/letsencrypt'
        - '/srv/docker/nginx/certs:/etc/nginx/certs'
        - '/srv/docker/nginx/sites-enabled:/etc/nginx/sites-enabled'


