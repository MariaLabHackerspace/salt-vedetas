#!/usr/bin/env python
pillar_path = 'pillar/docker/containers'

import argparse
import sys

try:
    import yaml
except ImportError:
    raise ImportError("""
    Missing pyyaml.
    For Debian/Ubuntu \'apt-get install python-yaml\'.
    You could also in any system \'pip install pyyaml\'.
                      """)


class MyParser(argparse.ArgumentParser):
    def error(self, message):
        sys.stderr.write('error: {}\n'.format(message))
        self.print_help()
        sys.exit(2)


class CreateDocker(object):
    """
        We generate a sls file for docker, ready to use for salt.
    """

    def __init__(self, vargs):
        # Remove empty items
        self.docker_dict = {k: v for k, v in vargs.items() if v is not None}
        self.docker_dict['name'] = self.docker_dict.pop('image_name')

        # Convert environment to python dict
        environment = dict()
        for variable in self.docker_dict['environment']:
            environment[variable.split('=')[0]] = variable.split('=')[1]
        self.docker_dict['environment'] = environment

        # Add whole dict inside docker->compose
        self.full_dict = {'docker': {'compose': {
            self.docker_dict['container_name']:
            self.docker_dict}}}

    def write_header(self):
        """
            docker/secret.sls is were we store sensitive data.
        """
        header = '{% import_yaml "docker/secret.sls" as secret %}\n\n'
        self.docker_file = "{}/{}.sls".format(
            pillar_path, self.docker_dict['container_name'])
        with open(self.docker_file, 'w') as yaml_file:
            try:
                yaml_file.write(header)
            except:
                return False
        return True

    def write_yaml(self):
        """
            Write command line arguments into yaml.
        """
        if self.write_header():
            with open(self.docker_file, 'a') as yaml_file:
                try:
                    yaml_file.write(yaml.dump(self.full_dict,
                                    default_flow_style=False,
                                    default_style='"'))
                except:
                    return False
            return True

    def print_yaml(self):
        """
            Print message and file content to stdout.
        """
        if self.write_yaml():
            yaml_file = open(self.docker_file, 'r')
            try:
                yaml_contents = yaml_file.read()
            except:
                return False
            yaml_file.close()

            # Set up ANSI colors output.
            CSI = "\x1B["
            print ""
            print CSI+"31;40m" + 'File ' + CSI+"32;40m" + self.docker_file\
                + CSI+"31;40m" + ' has been written.\n' + CSI + "0m"
            print yaml_contents
            return True

if __name__ == "__main__":
    parser = MyParser(description='Create sls docker for salt.')
    parser.add_argument('-n', '--container_name', required=True, metavar='',
                        help='A custom name for your container.')
    parser.add_argument('-v', '--volumes', action='append', metavar='',
                        help='Repeat the \'-v\' for more than one.')
    parser.add_argument('-l', '--links', action='append', metavar='',
                        help='Link container to existing one.')
    parser.add_argument('-p', '--ports', action='append', metavar='',
                        help='Repeat the \'-p\' for more than one.')
    parser.add_argument('-e', '--environment', action='append', metavar='',
                        help='repeat the \'-e\' for more than one.')
    parser.add_argument('image_name',
                        help='Could be in image:version format.\
                        Version could be \'latest\'')
    parser.add_argument('command', nargs='?',
                        help='Needs single quotes around spaced commands.')

    args = parser.parse_args()

    create_docker = CreateDocker(vars(args))
    create_docker.print_yaml()
