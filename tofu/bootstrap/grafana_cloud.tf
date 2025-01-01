data "onepassword_item" "grafana_bootstrap" {
  vault = data.onepassword_vault.automation.uuid
  title = "Grafana Cloud Bootstrap"
}

provider "grafana" {
  alias                     = "cloud"
  cloud_access_policy_token = data.onepassword_item.grafana_bootstrap.credential
}

resource "grafana_cloud_stack" "main" {
  provider = grafana.cloud

  name        = "bstuart"
  slug        = "bstuart"
  region_slug = "eu"
}

resource "grafana_cloud_stack_service_account" "cloud_sa" {
  provider   = grafana.cloud
  stack_slug = grafana_cloud_stack.main.slug

  name        = "Cloud service account"
  role        = "Admin"
  is_disabled = false
}

resource "grafana_cloud_stack_service_account_token" "cloud_sa" {
  provider   = grafana.cloud
  stack_slug = grafana_cloud_stack.main.slug

  name               = "${grafana_cloud_stack.main.slug} cloud_sa key"
  service_account_id = grafana_cloud_stack_service_account.cloud_sa.id
}

resource "grafana_cloud_access_policy" "write" {
  provider     = grafana.cloud
  region       = grafana_cloud_stack.main.region_slug
  name         = "write-policy"
  display_name = "Write Policy"

  scopes = [
    "metrics:write",
    "metrics:import",
    "logs:write",
    "traces:write",
    "profiles:write",
  ]

  realm {
    type       = "stack"
    identifier = grafana_cloud_stack.main.id
  }
}

resource "grafana_cloud_access_policy_token" "write" {
  provider         = grafana.cloud
  region           = grafana_cloud_stack.main.region_slug
  access_policy_id = grafana_cloud_access_policy.write.policy_id
  name             = "${grafana_cloud_access_policy.write.name}-token"
  display_name     = "${grafana_cloud_access_policy.write.display_name} Token"
}

resource "onepassword_item" "grafana_service_account" {
  vault = data.onepassword_vault.automation.uuid

  title    = "Grafana Cloud Stack"
  category = "login"

  username = grafana_cloud_stack_service_account.cloud_sa.id
  password = grafana_cloud_stack_service_account_token.cloud_sa.key

  section {
    label = "Details"
    field {
      label = "Stack Slug"
      value = grafana_cloud_stack.main.slug
    }
    field {
      label = "Stack ID"
      value = grafana_cloud_stack.main.id
    }
    field {
      label = "Stack URL"
      value = grafana_cloud_stack.main.url
    }
  }

  section {
    label = "Prometheus"
    field {
      label = "Write Endpoint"
      value = grafana_cloud_stack.main.prometheus_remote_write_endpoint
    }
    field {
      label = "User ID"
      value = grafana_cloud_stack.main.prometheus_user_id
    }
    field {
      label = "Token"
      value = grafana_cloud_access_policy_token.write.token
      type  = "CONCEALED"
    }
  }

  section {
    label = "Loki"
    field {
      label = "Write Endpoint"
      value = "${grafana_cloud_stack.main.logs_url}/loki/api/v1/push"
    }
    field {
      label = "User ID"
      value = grafana_cloud_stack.main.logs_user_id
    }
    field {
      label = "Token"
      value = grafana_cloud_access_policy_token.write.token
      type  = "CONCEALED"
    }
  }

  tags = ["ManagedBy:OpenTofu"]
}
