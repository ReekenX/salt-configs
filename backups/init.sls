upload-backups-software:
  file.recurse:
    - source: salt://resources/backups/google-cloud-sdk/
    - name: /root/.google-cloud-sdk

install-pyopenssl:
  pkg.installed:
    - name: python-openssl
    - watch:
      - file: upload-backups-software

register-backup-credential:
  cmd.wait:
    - name: /root/.google-cloud-sdk/init.sh
    - watch:
      - pkg: install-pyopenssl

remove-security-certificate:
  cmd.wait:
    - name: rm /root/.google-cloud-sdk/certificate.p12
    - watch:
      - cmd: register-backup-credential

install-files-backups-script:
  file.managed:
    - source: salt://resources/backups/backup-files.bash
    - name: /usr/local/sbin/backup-files.bash
    - mode: '0700'
    - watch:
      - cmd: remove-security-certificate

install-db-backups-script:
  file.managed:
    - source: salt://resources/backups/backup-db.bash
    - name: /usr/local/sbin/backup-db.bash
    - mode: '0700'
    - watch:
      - cmd: remove-security-certificate

bash /usr/local/sbin/backup-files.bash:
  cron.present:
    - identifier: SaltFilesBackupsScript
    - user: root
    - minute: random
    - hour: 4
    - watch:
      - file: install-files-backups-script

bash /usr/local/sbin/backup-db.bash:
  cron.present:
    - identifier: SaltDbBackupsScript
    - user: root
    - minute: random
    - hour: '6,18'
    - watch:
      - file: install-db-backups-script
