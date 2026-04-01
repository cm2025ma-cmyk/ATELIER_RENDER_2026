output "service_name" {
  value = render_web_service.flask_app.name
}

output "flask_url" {
  value       = render_web_service.flask_app.url
  description = "URL du service Flask"
}

output "adminer_url" {
  value       = render_web_service.adminer.url
  description = "URL du service Adminer"
}

output "db_connection_string" {
  value       = render_postgres.db.connection_info.external_connection_string
  description = "PostgreSQL connection string"
  sensitive   = true
}
