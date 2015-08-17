gitolite-package:
  pkg.installed:
    - name: gitolite3

gitolite-user:
  user.present:
    - name: git
    - home: /var/lib/gitolite3
    - require:
      - pkg: gitolite-package

gitolite-pubkey:
  file.managed:
    - source: salt://resources/ssh_keys/git.pubkey
    - name: /var/lib/gitolite3/admin.pub
    - user: git
    - group: git
    - require:
      - user: gitolite-user

gitolite-setup:
  cmd.wait:
    - name: gitolite setup -pk /var/lib/gitolite3/admin.pub
    - user: git
    - watch:
      - file: gitolite-pubkey
