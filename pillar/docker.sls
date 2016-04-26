{% import_yaml "docker-secret.sls" as secret %}

docker-pkg:
  lookup:
      version: '1.10.3-0~jessie'

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

    mail:
      container_name: 'mailserver_mail_1'
      image: 'tvial/docker-mailserver:latest'
      restart: 'always'
      hostname: 'lmahin'
      domainname: 'vedetas.org'
      ports:
        - "25:25"
        - "143:143"
        - "587:587"
        - "993:993"
      volumes:
        - '/srv/docker/mailserver/spamassassin:/tmp/spamassassin/'
        - '/srv/docker/mailserver/postfix:/tmp/postfix/'
        - '/srv/docker/mailserver/certs:/etc/letsencrypt'
        - '/srv/docker/mailserver/maildata:/var/mail'
      environment:
        DMS_SSL: letsencrypt
        SASL_PASSWORD: {{ secret.mail.sasl_password }}
        VIRTUAL_HOST: lmahin.vedetas.org

    mysql:
      container_name: 'dbmysql'
      image: 'mysql:latest'
      restart: 'always'
      environment:
        MYSQL_HOSTNAME: '172.17.0.2'
        MYSQL_ROOT_PASSWORD: {{ secret.mysql.mysql_root_password }}
      ports: 
        - '3355:3306'
      volumes:
        - '/srv/docker/mysql/data:/var/lib/mysql'

     ep_mysql:
       container_name: 'ep_mysql'
       image: 'mysql:latest'
       restart: 'always'
       environment: 
         MYSQL_ROOT_PASSWORD: {{ secret.ep_mysql.mysql_root_password }}
       volumes:
         - '/srv/docker/etherpad/mysql/data:/var/lib/mysql'

      etherpad:
        container_name: 'etherpad'
        image: 'tvelocity/etherpad-lite:latest'
        restart: 'always'
        ports:
          - '8002:9001'
