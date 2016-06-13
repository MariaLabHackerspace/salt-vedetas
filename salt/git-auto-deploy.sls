lockfile:
  pip.installed

olipo186:
  pkgrepo.managed:
    - name: deb http://ppa.launchpad.net/olipo186/git-auto-deploy/ubuntu xenial main
    - keyid: 0199DC32 
    - keyserver: keyserver.ubuntu.com
    - file: /etc/apt/sources.list.d/olipo186.list
  pkg.latest:
    - name: git-auto-deploy
    - require: 
      - pip: lockfile
    - refresh: True
