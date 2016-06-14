{% import_yaml "docker/secret.sls" as secret %}

docker:
  compose:
    mysql:
      container_name: 'dbmysql'
      image: 'mysql:latest'
      restart: 'always'
      environment:
        MYSQL_ROOT_PASSWORD: {{ secret.mysql.mysql_root_password }}
      ports: 
        - '3355:3306'
      volumes:
        - '/srv/docker/mysql/data:/var/lib/mysql'

