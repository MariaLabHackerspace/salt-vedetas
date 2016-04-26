docker-pkg:
  lookup:
    version: '1.10.3-0~jessie'

include:
{% for container_file in salt['cmd.run']('ls /srv/provision/pillar/docker/containers', python_shell=True).splitlines() %}
  {% set container = container_file.split('.')[0] %}
  - docker.containers.{{ container }}
{% endfor %}
