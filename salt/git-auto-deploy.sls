olipo186:
  pkgrepo.managed:
    - name: deb http://ppa.launchpad.net/olipo186/git-auto-deploy/ubuntu devel main
    - ppa: olipo186/git-auto-deploy
    - keyid: 0199DC32 
    - keyserver: keyserver.ubuntu.com
  pkg.latest:
    - name: git-auto-deploy
    - refresh: True
