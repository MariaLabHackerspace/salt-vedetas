# vi: set ft=yaml:
# example docker registry container
# if you want to your own docker registry, use this
# docker-containers:
#   lookup:
#     site-vedetas_org:
#       image: 'richarvey/nginx-php-fpm:latest'
#       cmd:
#       runoptions:
#         - "--env=VIRTUAL_HOST=vedetas.org"
#         - "--volume=/srv/docker/nginx/www/vedetas.org/htdocs:/usr/share/nginx/html"
#         - "--restart=always"
#         - "--detach=true"
#         - "-p 80:80"
# 
docker-pkg:
  lookup:
      # pip:
      # piversion: '== 8.1.1'
      version: '1.10.3-0~jessie'
    # refresh_repo: false
    # process_signature: /usr/bin/docker
    # # pip version is needed to maintain backwards compatibility with the above docker version
    # pip_version: '<= 1.2.3'
    # config:
    #   - DOCKER_OPTS="-s btrfs --dns 192.168.0.2"
    #   - export http_proxy="http://192.168.0.4:3128/"

# docker registry 2.x using the deprecated docker.registry - backwards compatibility
#registry:
#  lookup:
#    version: 2
#    restart: always
#    runoptions:
#      - "-e REGISTRY_LOG_LEVEL=warn"
#      - "-e REGISTRY_STORAGE=s3"
#      - "-e REGISTRY_STORAGE_S3_REGION=us-west-1"
#      - "-e REGISTRY_STORAGE_S3_BUCKET=my-bucket"
#      - "-e REGISTRY_STORAGE_S3_ROOTDIRECTORY=my-folder/my-subfolder/my-sub-subfolder"
#      - "--log-driver=syslog"

# docker registry < 1 using the deprecated, even older docker.registry - backwards compatibility
#registry:
#  lookup:
#    restart: 'always'
#    amazon:
#      aws_bucket: 'my-registry'
#      aws_key: 'ABCDEFGHIJK123456789'
#      aws_secret: 'AbcD+efG-HIjK1+++23456+789'

# Docker compose supported attributes
docker:
  compose:
    site-vedetas_org:
      container_name: 'site-vedetas_org'
      image: 'richarvey/nginx-php-fpm:latest'
      restart: 'always'
      ports:
        - '80:80'
        - '443:443'
      environment:
        VIRTUAL_HOST: 'vedetas.org'
      volumes:
        - '/srv/docker/nginx/www/vedetas.org/htdocs:/usr/share/nginx/html'
        - '/etc/letsencrypt:/etc/letsencrypt'
        - '/srv/docker/nginx/certs:/etc/nginx/certs'
        - '/srv/docker/nginx/sites-enabled:/etc/nginx/sites-enabled'
