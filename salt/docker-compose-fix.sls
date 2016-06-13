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
{%- endif %}
