{% import_yaml "docker/secret.sls" as secret %}

"docker":
  "compose":
    "wiki-vedetas_org":
      "container_name": "wiki-vedetas_org"
      "image": "richarvey/nginx-php-fpm:latest"
      "environment":
        "VIRTUAL_HOST": "almerinda.vedetas.org"
      "links":
      - "dbmysql:mysql"
      "name": "richarvey/nginx-php-fpm:latest"
      "volumes":
      - "/srv/docker/nginx/www/almerinda.vedetas.org/public:/usr/share/nginx/html"
      - "/etc/letsencrypt:/etc/letsencrypt"
      - "/srv/docker/nginx/certs:/etc/nginx/certs"
      - "/srv/docker/nginx/nginx-startup:/tmp/nginx-startup"
      "command": "/tmp/nginx-startup/start.sh"

