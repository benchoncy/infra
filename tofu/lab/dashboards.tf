resource "grafana_folder" "nodes" {
  provider = grafana.stack

  title = "Nodes"
}

resource "grafana_dashboard" "node_overview" {
  provider    = grafana.stack
  folder      = grafana_folder.nodes.id
  config_json = file("${path.module}/dashboards/node_overview.json")
}
