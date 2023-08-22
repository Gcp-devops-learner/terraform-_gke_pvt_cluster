locals {
  region               = "asia-south1"
  org_id               = "664894405813"
  billing_account      = "01EC42-60DAEA-EF98C0"
  host_project_name    = "km1-runcloud"
  service_project_name = "service-project1-367504"
  //host_project_id      = "${local.host_project_name}-${random_integer.int.result}"
  //service_project_id   = "${local.service_project_name}-${random_integer.int.result}"
  projects_api = "container.googleapis.com"
  secondary_ip_ranges = {
    "pod-ip-range"      = "10.0.0.0/14",
    "services-ip-range" = "10.4.0.0/19"
  }
}