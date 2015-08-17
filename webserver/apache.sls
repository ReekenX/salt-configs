apache:
  pkg.installed:
    - name: apache2
  service.running:
    - name: apache2
    - enable: True

apache-reload:
  module.wait:
    - name: service.reload
    - m_name: apache2

apache-restart:
  module.wait:
    - name: service.restart
    - m_name: apache2
