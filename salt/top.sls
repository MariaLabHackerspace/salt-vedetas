base:
  '*':
    - base
    - openssh.config
    - openssh.banner
    - vsftpd.config
    - fail2ban.config
    - fail2ban-fix
    - docker-compose-fix
    - docker
    - docker.compose-ng
    - git-auto-deploy
