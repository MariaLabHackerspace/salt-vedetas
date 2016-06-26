base:
  '*':
{%- if salt['file.file_exists']('openssh.sls') %}
    - openssh
{%- endif %}
{% if salt['file.file_exists']('vsftpd.sls') %}
    - vsftpd
{%- endif %}
{% if salt['file.file_exists']('fail2ban.sls') %}
    - fail2ban
{%- endif %}
    - docker
