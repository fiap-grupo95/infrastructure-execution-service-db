variable "mongodb_atlas_public_key" {
  type      = string
  sensitive = true
}

variable "mongodb_atlas_private_key" {
  type      = string
  sensitive = true
}

variable "mongodb_atlas_org_id" {
  type      = string
  sensitive = true
}

variable "mongodb_atlas_project_name" {
  type    = string
  default = "execution-service"
}

variable "mongodb_atlas_cluster_name" {
  type    = string
  default = "execution-service-cluster"
}

variable "mongodb_atlas_aws_region" {
  type    = string
  default = "US_EAST_1"
}

variable "mongodb_atlas_instance_size" {
  type    = string
  default = "M10"
}

variable "mongodb_atlas_mongodb_major_version" {
  type    = string
  default = "7.0"
}

variable "mongodb_atlas_allow_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "mongodb_atlas_db_username" {
  type    = string
  default = "execution_service"
}

variable "mongodb_database" {
  type    = string
  default = "execution-service-db"
}

variable "mongo_seed_default_password" {
  type      = string
  sensitive = true
  default   = "abc123"
}
