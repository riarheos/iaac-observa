grafana-pkg:
  pkg.installed:
    - sources:
        - grafana: https://dl.grafana.com/oss/release/grafana_11.1.3_amd64.deb

/etc/grafana/provisioning/datasources/prometheus.yaml:
  file.managed:
    - source: salt://{{ slspath }}/prometheus.yaml

grafana-server:
  service.running:
    - watch:
        - file: /etc/grafana/provisioning/datasources/prometheus.yaml