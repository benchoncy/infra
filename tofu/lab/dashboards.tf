resource "grafana_folder" "nodes" {
  provider = grafana.stack

  title = "Nodes"
}
