{% import_yaml "docker-secret.sls" as secret %}

docker:
  compose:
    postgresql:
      container_name: 'redmine_postgresql_1'
      image: 'sameersbn/postgresql:9.4-8'
      restart: 'always'
      environment:
        DB_USER: {{ secret.postgresql.psql_user }}
        DB_PASS: {{ secret.postgresql.psql_pass }}
        DB_NAME: 'redmine_production'
      volumes:
        - '/srv/docker/redmine/postgresql:/var/lib/postgresql'

