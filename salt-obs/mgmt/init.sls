packages:
  pkg.installed:
    - pkgs:
        - prometheus

/etc/prometheus/prometheus.yml:
  file.managed:
    - source: salt://{{ slspath }}/files/prometheus.yml.j2
      template: jinja

prometheus:
  service.running:
    - watch:
        - file: /etc/prometheus/prometheus.yml
