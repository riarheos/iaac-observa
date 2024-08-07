nginx:
  pkg.installed

/var/www/html/whale.svg:
  file.managed:
    - source: salt://{{ slspath }}/files/whale.svg

/var/www/html/index.html:
  file.managed:
    - source: salt://{{ slspath }}/files/index.html.j2
      template: jinja
