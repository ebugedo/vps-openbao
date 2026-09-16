storage "file" {
  path = "/openbao/file"
}

listener "tcp" {
  address       = "0.0.0.0:8200"
  tls_disable   = 1

  # Enable unauthenticated access for health checks
  # (Nginx handles TLS termination)
  telemetry {
    unauthenticated_metrics_access = true
  }
}

api_addr     = "http://0.0.0.0:8200"
cluster_addr = "http://0.0.0.0:8201"

ui = true

# Disable mlock for container environments
disable_mlock = true

# Telemetry
telemetry {
  prometheus_retention_time = "30s"
  disable_hostname          = true
}
