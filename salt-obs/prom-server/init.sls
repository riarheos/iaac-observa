prometheus-pkg:
  pkg.installed:
    - pkgs:
        - prometheus

/etc/prometheus/prometheus.yml:
  file.managed:
    - source: salt://{{ slspath }}/prometheus.yml.j2
      template: jinja

/etc/prometheus/rules:
  file.directory

/etc/prometheus/rules/nginx.yml:
  file.managed:
    - source: salt://{{ slspath }}/nginx.yml.j2
      template: jinja

prometheus:
  service.running:
    - watch:
        - file: /etc/prometheus/prometheus.yml
        - file: /etc/prometheus/rules/nginx.yml
