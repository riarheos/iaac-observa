nginx:
  pkg.installed

/var/www/html/whale.svg:
  file.managed:
    - source: salt://nginx/files/whale.svg

/var/www/html/index.html:
  file.managed:
    - source: salt://nginx/files/index.html.j2
      template: jinja
