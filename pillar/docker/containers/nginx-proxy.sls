{% import_yaml "docker/secret.sls" as secret %}

"docker":
  "compose":
    "nginx-proxy":
      "container_name": "nginx-proxy"
      "image": "jwilder/nginx-proxy:latest"
      "ports":
      - "80:80"
      - "443:443"
      "restart": "always"
      "volumes":
      - "/var/run/docker.sock:/tmp/docker.sock:ro"
      - "/etc/letsencrypt:/etc/letsencrypt"
      - "/srv/docker/nginx/certs:/etc/nginx/certs"
