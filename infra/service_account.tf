resource "google_service_account" "cicd" {
  account_id   = "django-cicd-sa-001"
  display_name = "Django CI/CD SA"
}