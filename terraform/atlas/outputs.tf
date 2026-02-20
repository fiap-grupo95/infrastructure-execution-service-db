output "mongodb_atlas_project_id" {
  value = mongodbatlas_project.this.id
}

output "mongodb_atlas_cluster_name" {
  value = mongodbatlas_cluster.this.name
}

output "mongodb_atlas_connection_string" {
  value = mongodbatlas_cluster.this.connection_strings[0].standard_srv
}

output "mongodb_database" {
  value = var.mongodb_database
}

output "mongodb_username" {
  value = mongodbatlas_database_user.app.username
}
