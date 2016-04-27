#!/usr/bin/env python

import argparse
import yaml

class CreateDocker(object):
    """
        We generate a sls file for docker, ready to use for salt.
    """

    def get_args(self):
        """
            Get command line arguments
        """
        parser = argparse.ArgumentParser(description='Create yaml docker for salt.')
        parser.add_argument('-n', '--container_name', required=True)
        parser.add_argument('-v', '--volumes')
        # parser.add_argument('-l', '--links', help='Link container to existing one.')
        # parser.add_argument('-p', '--ports')
        parser.add_argument('image')

        args = parser.parse_args()
        return args

    def default_dict(self):
        """
            We put our args inside docker->compose.
        """
        docker_dict = dict((key, value) for key, value in vars(self.get_args()).iteritems() if value is not None)
        docker_dict['restart'] = 'always'
        full_dict = {'docker': {'compose': { self.get_args().container_name : docker_dict}}}
        return full_dict

    def write_header(self):
        """
            docker/secret.sls is were we store sensitive data.
        """
        header = '{% import_yaml "docker/secret.sls" as secret %}\n\n'
        with open("{}.sls".format(self.get_args().container_name), 'w') as docker_file:
            docker_file.write(header)

    def write_yaml(self):
        """
            Write command line arguments into yaml.
        """
        self.write_header()
        with open("{}.sls".format(self.get_args().container_name), 'a') as docker_file:
            docker_file.write(yaml.dump(self.default_dict(), default_flow_style=False))

    def write_extras(self):
        """
            Commented out extra arguments.
        """
        self.write_yaml()
        extras = """
          {#
          links: 
            - 'name:alias' 
          ports:
            - '80:80' 
          #}
        """
        with open("{}.sls".format(self.get_args().container_name), 'a') as docker_file:
            docker_file.write(extras)

if __name__ == "__main__":
    create_docker = CreateDocker()
    create_docker.write_extras()
