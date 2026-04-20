resource "google_cloud_run_service" "app" {
  name     = "${var.service_name}-${var.environment}"
  location = var.region

  template {
    spec {
      containers {
        image = "us-central1-docker.pkg.dev/${var.project_id}/django-repo/django-app"

        ports {
          container_port = 8080
        }

        # SECRET FROM SECRET MANAGER
        env {
          name = "DJANGO_SECRET_KEY"

          value_from {
            secret_key_ref {
              name = "django-secret-key"
              key  = "latest"
            }
          }
        }

        # OTHER ENV VARS
        env {
          name  = "DJANGO_DEBUG"
          value = "False"
        }

        env {
          name  = "ALLOWED_HOSTS"
          value = ".run.app,localhost"
        }

        env {
          name  = "ENVIRONMENT"
          value = var.environment
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  # 🧱 PREVENT TERRAFORM VS CI/CD CONFLICT
  lifecycle {
    ignore_changes = [
      template[0].spec[0].containers[0].image
    ]
  }
}