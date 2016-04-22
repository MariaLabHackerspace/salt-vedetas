fail2ban:
    lookup:
        config:
            loglevel: 2
            ignoreip: [127.0.0.1/8, 172.17.0.0/16]
            bantime: 3600
            maxretry: 3
            backend: auto
        jails:
            ssh:
                action:
                    - iptables[name=SSH, port=ssh, protocol=tcp]
                enabled: 'true'
                filter: sshd
                logpath: /var/log/auth.log
                maxretry: 6
                port: ssh
            ssh_ddos:
                action:
                    - iptables[name=SSH, port=ssh, protocol=tcp]
                enabled: 'true'
                filter: sshd-ddos
                logpath: /var/log/auth.log
                maxretry: 6
                port: ssh
