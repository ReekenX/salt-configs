access-list-allow-root-auth-with-privatekey:
  file.append:
      - name: /etc/ssh/sshd_config
      - text: |
              PermitRootLogin without-password
              LoginGraceTime 60
      - order: 1

access-list-custom-ssh-allowed-list:
  file.blockreplace:
    - name: /etc/ssh/sshd_config
    - marker_start: "# START Custom allowed ssh users list"
    - marker_end: "# END Custom allowed ssh users list"
    - content: |
               AllowUsers root
               AllowUsers ubuntu
               AllowUsers remigijus
    - append_if_not_found: True
    - backup: '.bak'
    - show_changes: True
    - order: 1

access-list-remigijus:
  user.present:
    - name: remigijus
    - shell: /bin/bash
    - home: /home/remigijus
  ssh_auth:
    - present
    - user: remigijus
    - source: salt://resources/security_users/remigijus.pubkey
    - order: 3
    - require:
      - user: remigijus

access-list-root:
  ssh_auth:
    - present
    - user: root
    - source: salt://resources/security_users/root.pubkey
    - order: 3

access-list-reload-ssh:
  cmd.run:
    - name: service ssh restart
    - order: 2
