compose-pip:
  pkg.installed:
    - name: python-pip
  pip.installed:
    - name: pip
    - upgrade: True

compose:
  pip.installed:
    - name: docker-compose == 1.7.0

{%- if salt['grains.get']('oscodename') == 'trusty' %}
urllib3:
  pip.installed:
    - name: urllib3 == 1.14
    - upgrade: True
    - reload_modules: true
{%- endif %}

/srv/docker/etherpad/confpad/package.json:
  file.managed:
    - source: salt://docker-compose-fix/package.json
    - makedirs: True

/srv/docker/etherpad/confpad/custom_commands.sh:
  file.managed:
    - makedirs: True
    - mode: 0755
    - contents: |
        #!/bin/bash

        test -h package.json || ln -s /opt/etherpad-lite/{var,}/package.json
        npm install
        bin/run.sh --root


