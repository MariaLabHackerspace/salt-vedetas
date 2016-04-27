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
        parser = argparse.ArgumentParser(
            description='Create yaml docker for salt.')
        parser.add_argument('-n', '--container_name', required=True)
        parser.add_argument('-v', '--volumes', action='append')
        parser.add_argument('-l', '--links', action='append',
                            help='Link container to existing one.')
        parser.add_argument('-p', '--ports', action='append')
        parser.add_argument('-e', '--environment', action='append')
        parser.add_argument('image_name')
        parser.add_argument('command', nargs='?')

        args = parser.parse_args()
        return args

    def order_args(self):
        docker_dict = dict()
        docker_dict['container_name'] = self.get_args().container_name
        docker_dict['image'] = self.get_args().image_name
        docker_dict['restart'] = 'always'
        if self.get_args().command is not None:
            docker_dict['command'] = self.get_args().command
        if self.get_args().volumes is not None:
            docker_dict['volumes'] = self.get_args().volumes
        if self.get_args().links is not None:
            docker_dict['links'] = self.get_args().links
        if self.get_args().ports is not None:
            docker_dict['ports'] = self.get_args().ports

        docker_dict['environment'] = dict()
        if self.get_args().environment is not None:
            for variable in self.get_args().environment:
                docker_dict['environment'][variable.split('=')[0]] = variable.split('=')[1]

        return docker_dict

    def default_dict(self):
        """
            We put our args inside docker->compose.
        """
        full_dict = {'docker': {'compose': {self.get_args().container_name:
                                            self.order_args()}}}
        return full_dict

    def write_header(self):
        """
            docker/secret.sls is were we store sensitive data.
        """
        header = '{% import_yaml "docker/secret.sls" as secret %}\n\n'
        with open("{}.sls".format(
                  self.get_args().container_name), 'w') as docker_file:
            docker_file.write(header)

    def write_yaml(self):
        """
            Write command line arguments into yaml.
        """
        self.write_header()
        with open("{}.sls".format(
                  self.get_args().container_name), 'a') as docker_file:
            docker_file.write(yaml.dump(
                self.default_dict(),
                default_flow_style=False, default_style='"'))

if __name__ == "__main__":
    create_docker = CreateDocker()
    create_docker.write_yaml()
