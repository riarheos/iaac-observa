nginx:
  pkg.installed

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

nginx_service:
  service.running:
    - name: nginx
    - reload: true
    - watch:
        - file: /etc/nginx/sites-enabled/default