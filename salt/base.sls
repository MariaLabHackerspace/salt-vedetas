/srv/docker/nginx/www:
  file.directory:
    - makedirs: True

ftpuser:
  user.present:
  - home: /srv/docker/nginx/www

srv_docker_nginx_www:
  file.directory:
    - name: /srv/docker/nginx/www
    - user: ftpuser
    - group: root
    - makedirs: True

extra-packages:
  pkg.installed:
    - names:
      - telnet
      - git
      - vim
      - htop
