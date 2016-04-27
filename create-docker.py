#!/usr/bin/env python

import argparse
import yaml

def get_args():
    parser = argparse.ArgumentParser(description='Create yaml docker for salt.')
    parser.add_argument('-n', '--container_name', required=True)
    parser.add_argument('-v', '--volumes')
    # parser.add_argument('-l', '--links', help='Link container to existing one.')
    # parser.add_argument('-p', '--ports')
    parser.add_argument('image')

    args = parser.parse_args()
    return args

def default_dict():
    docker_dict = dict((key, value) for key, value in vars(get_args()).iteritems() if value is not None)
    docker_dict['restart'] = 'always'
    full_dict = {'docker': {'compose': { get_args().container_name : docker_dict}}}
    return full_dict

def write_header():
    header = '{% import_yaml "docker/secret.sls" as secret %}\n\n'
    with open("{}.sls".format(get_args().container_name), 'w') as docker_file:
        docker_file.write(header)

def write_yaml():
    write_header()
    with open("{}.sls".format(get_args().container_name), 'a') as docker_file:
        docker_file.write(yaml.dump(default_dict(), default_flow_style=False))

def write_extras():
    write_yaml()
    extras = """
      {#
      links: 
        - 'name:alias' 
      ports:
        - '80:80' 
      #}
    """
    with open("{}.sls".format(get_args().container_name), 'a') as docker_file:
        docker_file.write(extras)

if __name__ == "__main__":
    write_extras()
    # print get_args().container_name
