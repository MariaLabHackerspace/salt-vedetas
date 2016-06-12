{% import_yaml "docker/secret.sls" as secret %}

docker:
  compose:
    ethercalc:
      container_name: 'ethercalc'
      image: 'audreyt/ethercalc:latest'
      restart: 'always'
      links:
        - 'ec_redis:ec_redis'
      ports:
        - '8001:8000'
      environment:
        VIRTUAL_HOST: 'eveliyn.vedetas.org'
        CERT_NAME: 'evelyn.vedetas.org'
