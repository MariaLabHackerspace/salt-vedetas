base:
  '*':
    - base
    - vsftpd.config
    - fail2ban.config
    - fail2ban-fix

  'debian-jessie.vagrantup.com':
    - docker
    - docker-compose-fix
    - docker.compose-ng
    - git-auto-deploy
