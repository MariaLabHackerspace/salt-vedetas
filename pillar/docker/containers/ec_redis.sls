{% import_yaml "docker-secret.sls" as secret %}

docker:
  compose:
    ec_redis:
      container_name: 'ec_redis'
      image: 'redis:latest'
      restart: 'always'
      command: 'redis-server --appendonly yes'
      volumes:
        - '/srv/docker/ethercalc/data:/data'
