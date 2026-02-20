terraform {
  required_version = ">= 1.5.0"

  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "~> 1.17"
    }
  }
}

provider "mongodbatlas" {
  public_key  = var.mongodb_atlas_public_key
  private_key = var.mongodb_atlas_private_key
}

resource "mongodbatlas_project" "this" {
  name   = var.mongodb_atlas_project_name
  org_id = var.mongodb_atlas_org_id
}

resource "mongodbatlas_cluster" "this" {
  project_id                 = mongodbatlas_project.this.id
  name                       = var.mongodb_atlas_cluster_name
  cluster_type               = "REPLICASET"
  mongo_db_major_version     = var.mongodb_atlas_mongodb_major_version
  provider_name              = "AWS"
  provider_region_name       = var.mongodb_atlas_aws_region
  provider_instance_size_name = var.mongodb_atlas_instance_size

  auto_scaling_disk_gb_enabled = true

  replication_specs {
    num_shards = 1

    regions_config {
      region_name     = var.mongodb_atlas_aws_region
      electable_nodes = 3
      priority        = 7
      read_only_nodes = 0
      analytics_nodes = 0
    }
  }
}

resource "mongodbatlas_project_ip_access_list" "allowlist" {
  project_id = mongodbatlas_project.this.id
  cidr_block = var.mongodb_atlas_allow_cidr
  comment    = "Allow connections from this CIDR"
}

resource "mongodbatlas_database_user" "app" {
  project_id         = mongodbatlas_project.this.id
  username           = var.mongodb_atlas_db_username
  password           = var.mongo_seed_default_password
  auth_database_name = "admin"

  roles {
    role_name     = "readWrite"
    database_name = var.mongodb_database
  }
}
