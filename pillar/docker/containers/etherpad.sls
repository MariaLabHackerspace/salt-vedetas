{% import_yaml "docker/secret.sls" as secret %}

docker:
  compose:
    etherpad:
      container_name: 'etherpad'
      image: 'indiehosters/etherpad:latest'
      restart: 'always'
      links:
        - 'ep_mysql:mysql'
      volumes:
        - '/srv/docker/etherpad/confpad:/opt/etherpad-lite/var/'
      command: '/opt/etherpad-lite/var/custom_commands.sh'
      environment:
        VIRTUAL_HOST: 'antonieta.vedetas.org'
        {## VIRTUAL_PROTO: 'https' ##}
        {## VIRTUAL_PORT: 443 ##}
        CERT_NAME: 'antonieta.vedetas.org'
        ETHERPAD_ADMIN_PASSWORD: {{ secret.etherpad.admin_password|yaml_encode }}
        ETHERPAD_ADMIN_USER: {{ secret.etherpad.admin_user }}
        ETHERPAD_TITLE: 'Antonieta'
