# # Enable A Shared VPC in the host project
resource "google_compute_shared_vpc_host_project" "host" {
 project = var.project # Replace this with your host project ID in quotes
}

# To attach a first service project with host project 
resource "google_compute_shared_vpc_service_project" "service" {
  host_project    = google_compute_shared_vpc_host_project.host.project
  service_project = var.service_project1 # Replace this with your service project ID in quotes

  depends_on = [google_compute_shared_vpc_host_project.host]
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork_iam
resource "google_compute_subnetwork_iam_binding" "binding" {
  project    = google_compute_shared_vpc_host_project.host.project
  region     = google_compute_subnetwork.private.region
  subnetwork = google_compute_subnetwork.private.name

  role = "roles/compute.networkUser"
  members = [
    "serviceAccount:${google_service_account.km1-runcloud.email}",
    "serviceAccount:${google_project.km1-runcloud.number}@cloudservices.gserviceaccount.com",
    "serviceAccount:service-${google_project.km1-runcloud.number}@container-engine-robot.iam.gserviceaccount.com"
  ]
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam
resource "google_project_iam_binding" "container-engine" {
  project = google_compute_shared_vpc_host_project.host.project
  role    = "roles/container.hostServiceAgentUser"

  members = [
    "serviceAccount:service-${google_project.km1-runcloud.number}@container-engine-robot.iam.gserviceaccount.com",
  ]
  depends_on = [google_project_service.service]
}