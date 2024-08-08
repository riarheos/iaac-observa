/root/nginx.deb:
  file.managed:
    - source: salt://{{ slspath }}/files/nginx-core_1.18.0-6ubuntu14.4_amd64.deb

packages:
  pkg.installed:
    - sources:
        - nginx-core: /root/nginx.deb

/etc/nginx/sites-enabled/default:
  file.managed:
    - source: salt://{{ slspath }}/files/default.conf

/var/www/html/whale.svg:
  file.managed:
    - source: salt://{{ slspath }}/files/whale.svg

/var/www/html/index.html:
  file.managed:
    - source: salt://{{ slspath }}/files/index.html.j2
      template: jinja

/usr/bin/worker:
  file.managed:
    - source: salt://{{ slspath }}/files/worker
      mode: 755

/etc/systemd/system/worker.service:
  file.managed:
    - source: salt://{{ slspath }}/files/worker.service

nginx:
  service.running:
    - reload: true
    - watch:
        - file: /etc/nginx/sites-enabled/default

worker:
  service.running:
    - enable: true
    - reload: true