install-motd:
  file.managed:
    - source: salt://resources/motd
    - name: /etc/motd
    - mode: '0755'
