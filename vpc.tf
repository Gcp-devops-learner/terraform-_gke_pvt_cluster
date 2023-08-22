# # # Enable A Shared VPC in the host project
# resource "google_compute_shared_vpc_host_project" "host" {
#  project = google_project.host_project_name.number # Replace this with your host project ID in quotes

#  depends_on = [google_compute_network.network]
# }

# # To attach a first service project with host project 
# resource "google_compute_shared_vpc_service_project" "service" {
#   host_project    = google_compute_shared_vpc_host_project.host.project
#   service_project = var.service_project1 # Replace this with your service project ID in quotes

#   depends_on = [google_compute_shared_vpc_host_project.host]
# }



# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network
resource "google_compute_network" "main" {
  name                    = "gke-network"
  project                 = google_compute_shared_vpc_host_project.host.project
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
  mtu                     = 1500
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork
resource "google_compute_subnetwork" "private" {
  name                     = "gke-subnet"
  project                  = google_compute_shared_vpc_host_project.host.project
  ip_cidr_range            = "10.5.0.0/20"
  region                   = local.region
  network                  = google_compute_network.main.self_link
  private_ip_google_access = true

  # secondary_ip_range {
  #   range_name    = "pod-ip-range"
  #   ip_cidr_range = "10.0.0.0/14"
  # }

  # secondary_ip_range {
  #   range_name    = "services-ip-range"
  #   ip_cidr_range = "10.4.0.0/19"
  # }

  dynamic "secondary_ip_range" {
    for_each = local.secondary_ip_ranges

    content {
      range_name    = secondary_ip_range.key
      ip_cidr_range = secondary_ip_range.value
    }
  }
}

