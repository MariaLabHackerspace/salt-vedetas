{% import_yaml "docker-secret.sls" as secret %}

docker:
  compose:
    ep_mysql:
      container_name: 'ep_mysql'
      image: 'mysql:latest'
      restart: 'always'
      environment: 
        MYSQL_ROOT_PASSWORD: {{ secret.ep_mysql.mysql_root_password }}
      volumes:
        - '/srv/docker/etherpad/mysql/data:/var/lib/mysql'

