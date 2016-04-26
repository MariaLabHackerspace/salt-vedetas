{% import_yaml "docker-secret.sls" as secret %}

docker:
  compose:
    redmine:
      container_name: 'redmine_redmine_1'
      image: 'sameersbn/redmine:3.1.2-1'
      restart: 'always'
      links:
        - 'redmine_postgresql_1:postgresql'
      environment:
        TZ: 'Brazil/East'
        REDMINE_PORT: 80
        SMTP_ENABLED: True
        SMTP_DOMAIN: 'vedetas.org'
        SMTP_HOST: 'lmahin.vedetas.org'
        SMTP_PORT: 25
        SMTP_USER: {{ secret.redmine.imap_user }}
        SMTP_PASS: {{ secret.redmine.imap_pass }}
        SMTP_STARTTLS: False
        SMTP_AUTHENTICATION: ':login'
        SMTP_OPENSSL_VERIFY_MODE: 'none'
        IMAP_ENABLED: True
        IMAP_USER: {{ secret.redmine.imap_user }}
        IMAP_PASS: {{ secret.redmine.imap_pass }}
        IMAP_HOST: lmahin.vedetas.org
        IMAP_PORT: 143
        IMAP_SSL: False
        IMAP_INTERVAL: 30
        VIRTUAL_HOST: 'afra.vedetas.org'
      ports:
        - "80"
      volumes:
        - '/srv/docker/redmine/redmine:/home/redmine/data'

