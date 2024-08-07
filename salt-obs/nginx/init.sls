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

nginx:
  service.running:
    - reload: true
    - watch:
        - file: /etc/nginx/sites-enabled/default