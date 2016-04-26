{% import_yaml "docker/secret.sls" as secret %}

docker:
  compose:
    etherpad:
      container_name: 'etherpad'
      image: 'tvelocity/etherpad-lite:latest'
      restart: 'always'
      links:
        - 'ep_mysql:ep_mysql'
      ports:
        - '8002:9001'
