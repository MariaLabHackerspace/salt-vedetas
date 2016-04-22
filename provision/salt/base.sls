ftpuser:
  user.present:
  - home: /srv/docker/nginx/www

/srv/docker/nginx/www:
  file.directory:
    - user: ftpuser
    - group: ftpuser
    - makedirs: True

extra-packages:
  pkg.installed:
    - names:
      - telnet
      - git
      - vim
      - htop
