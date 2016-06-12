/etc/fail2ban/jail.conf:
  file.managed:
    - source: salt://fail2ban-fix/jail.conf
