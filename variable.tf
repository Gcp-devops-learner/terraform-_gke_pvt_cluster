variable "project" {
  description = "The host project ID"
  default     = "km1-runcloud"
}

variable "region" {
  type        = string
  description = "The region to host the cluster in (optional if zonal cluster / required if regional)"
  default     = "asia-south1"
}

variable "service_project1" {
  description = "The service project ID"
  default     = "service-project1-367504"
}
