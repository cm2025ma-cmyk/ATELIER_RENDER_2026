terraform {
  required_providers {
    render = {
      source  = "render-oss/render"
      version = ">= 1.7.0"
    }
  }
}

provider "render" {
  api_key  = var.render_api_key
  owner_id = var.render_owner_id
}

variable "github_actor" {
  description = "GitHub username"
  type        = string
}

# ─── PostgreSQL Managed Database ───────────────────────────────────────────────
resource "render_postgres" "db" {
  name   = "postgres-${var.github_actor}"
  region = "frankfurt"
  plan   = "free"
}

# ─── Flask Web Service ──────────────────────────────────────────────────────────
resource "render_web_service" "flask_app" {
  name   = "flask-render-iac-${var.github_actor}"
  plan   = "free"
  region = "frankfurt"

  env_vars = {
    ENV = {
      value = "production"
    }
    DATABASE_URL = {
      value = render_postgres.db.connection_info.external_connection_string
    }
  }

  runtime_source = {
    image = {
      image_url = var.image_url
      tag       = var.image_tag
    }
  }

  depends_on = [render_postgres.db]
}

# ─── Adminer Web Service ────────────────────────────────────────────────────────
resource "render_web_service" "adminer" {
  name   = "adminer-${var.github_actor}"
  plan   = "free"
  region = "frankfurt"

  env_vars = {
    ADMINER_DEFAULT_SERVER = {
      value = render_postgres.db.connection_info.host
    }
  }

  runtime_source = {
    image = {
      image_url = "adminer"
      tag       = "latest"
    }
  }

  depends_on = [render_postgres.db]
}
