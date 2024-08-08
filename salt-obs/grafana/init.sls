#grafana-pkg:
#  pkg.installed:
#    - sources:
#        - grafana: https://dl.grafana.com/oss/release/grafana_11.1.3_amd64.deb

/etc/grafana/provisioning/datasources/prometheus.yaml:
  file.managed:
    - source: salt://{{ slspath }}/prometheus.yaml

/etc/grafana/provisioning/dashboards/nginx.json:
  file.managed:
    - source: salt://{{ slspath }}/nginx.json

/etc/grafana/provisioning/dashboards/default.yaml:
  file.managed:
    - source: salt://{{ slspath }}/default.yaml

grafana-server:
  service.running:
    - watch:
        - file: /etc/grafana/provisioning/datasources/prometheus.yaml
        - file: /etc/grafana/provisioning/dashboards/nginx.json
        - file: /etc/grafana/provisioning/dashboards/default.yaml
