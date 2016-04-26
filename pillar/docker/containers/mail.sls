{% import_yaml "docker-secret.sls" as secret %}

docker:
  compose:
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

