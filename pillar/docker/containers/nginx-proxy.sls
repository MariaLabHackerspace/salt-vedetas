{% import_yaml "docker/secret.sls" as secret %}

"docker":
  "compose":
    "nginx-proxy":
      "container_name": "nginx-proxy"
      "environment": {}
      "image": "jwilder/nginx-proxy"
      "ports":
      - "80:80"
      - "443:443"
      "restart": "always"
      "volumes":
      - "/etc/letsencrypt:/etc/letsencrypt"
      - "/srv/docker/nginx/vhost.d:/etc/nginx/vhost.d:ro"
      - "/var/run/docker.sock:/tmp/docker.sock:ro"
