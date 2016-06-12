base:
  '*':
    - vsftpd
    - fail2ban
    - docker

  'debian-jessie.vagrantup.com':
    - nginx
