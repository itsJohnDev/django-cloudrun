variable "project_id" {}
variable "region" {
  default = "us-central1"
}
variable "service_name" {
  default = "django-app"
}

variable "environment" {
  description = "Deployment environment (staging or prod)"
  type        = string
}