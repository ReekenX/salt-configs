include:
  - apache

jenkins:
  pkg.installed:
    - name: jenkins

a2enmod rewrite:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/rewrite.load
    - order: 225
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart

a2enmod ssl:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/ssl.load
    - order: 225
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart

a2enmod proxy:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/proxy.load
    - order: 225
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart

a2enmod proxy_http:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/proxy_http.load
    - order: 225
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart

a2enmod headers:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/headers.load
    - order: 225
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart

jenkins-default-host:
  file.managed:
    - source: salt://resources/gitolite/000-default.conf
    - name: /etc/apache2/sites-enabled/000-default.conf
    - user: git
    - group: git
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart

jenkins-ssl-host:
  file.managed:
    - source: salt://resources/gitolite/default-ssl.conf
    - name: /etc/apache2/sites-available/default-ssl.conf
    - user: git
    - group: git
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart

a2ensite default-ssl:
  cmd.run:
    - unless: ls /etc/apache2/sites-enabled/default-ssl.conf
    - order: 225
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart

jenkins-restart:
  module.wait:
    - name: service.restart
    - m_name: jenkins
    - require:
      - pkg: jenkins
    - watch_in:
      - module: apache-restart

jenkins-config-append:
  file.append:
    - name: /etc/default/jenkins
    - text: |
        JENKINS_ARGS="--webroot=/var/cache/jenkins/war --httpPort=$HTTP_PORT --ajp13Port=$AJP_PORT --prefix=$PREFIX"
    - require:
      - pkg: jenkins
    - watch_in:
      - module: jenkins-restart
