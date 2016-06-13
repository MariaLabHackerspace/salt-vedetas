# salt-vedetas [![Build Status](https://travis-ci.org/MariaLabHackerspace/salt-vedetas.svg?branch=master)](https://travis-ci.org/MariaLabHackerspace/salt-vedetas)
--
Este repositório guarda um conjunto de arquivos sls de salt necessários para configurar e manter a servidora vedetas.org.

salt-vedetas foi testado no Debian Jessie e Ubuntu Trusty. Deve funcionar em outras versões de Debian e Ubuntu sem muita dificuldade, contanto que a versão não seja muito antiga. 

### Instalação

O meio mais fácil de usar estas fórmulas num ambiente de testes é com [vagrant](https://www.vagrantup.com/) e [virtualbox](https://www.virtualbox.org/).

Instale ambos em seu sistema. Vagrant e virtualbox podem ser instalados nos principais sistemas operacionais como Linux, OSX e Windows. 

    $ git clone https://github.com/MariaLabHackerspace/salt-vedetas.git
    $ cd salt-vedetas
    $ cp .travis/travis_secret.sls pillar/docker
    $ vagrant up local

E pronto! Em poucos minutos você terá uma versão de testes da servidora na sua máquina local, com TUDO configurado.

### Configuração

As configurações/personalizações estão todas dentro do diretório pillar. As senhas podem ser configuradas em pillar/docker/secret.sls. JAMAIS inclua este arquivo no repositório público.

Para criar um novo container temos um script para gerar um sls, tornando a tarefa mais fácil:

Exemplo:

    $ python create-docker.py -n meu-blog -v '/srv/docker/nginx/www/meu-blog.org/htdocs:/usr/share/nginx/html' -v '/etc/letsencrypt:/etc/letsencrypt' -v '/srv/docker/
    nginx/certs:/etc/nginx/certs' -v '/srv/docker/nginx/sites-enabled:/etc/nginx/sites-enabled' -l 'dbmysql:mysql' -e 'VIRTUAL_HOST=meublog.org,www.meublog.org' -e 'CERT_NAME=meublog.org' richarvey/nginx-php-fpm

Esse comando vai gerar `pillar/docker/containers/meu-blog.sls`:

```yaml

{% import_yaml "docker/secret.sls" as secret %}

"docker":
  "compose":
    "meu-blog":
      "container_name": "meu-blog"
      "environment":
        "CERT_NAME": "meublog.org"
        "VIRTUAL_HOST": "meublog.org,www.meublog.org"
      "links":
      - "dbmysql:mysql"
      "name": "richarvey/nginx-php-fpm"
      "volumes":
      - "/srv/docker/nginx/www/meu-blog.org/htdocs:/usr/share/nginx/html"
      - "/etc/letsencrypt:/etc/letsencrypt"
      - "/srv/docker/nginx/certs:/etc/nginx/certs"
      - "/srv/docker/nginx/sites-enabled:/etc/nginx/sites-enabled"
```

Óbviamente você também pode criar esse sls manualmente, mantendo o cuidado de seguir rigorosamente as identações. 
