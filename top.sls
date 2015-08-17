base:
  '*':
    - security.users
    - security.packages
    - webserver.motd
    - time
  'webserver-*':
    - webserver.software
    - backups
  'qa-*':
    - webserver.software
    - webserver.gitolite
    - webserver.jenkins
    - webserver.munin
    - webserver.django
    - backups
  'pm-*':
    - webserver.software
    - backups
