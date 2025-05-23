variable "cf_org_name" {
  type        = string
  description = "cloud.gov organization name"
}

variable "cf_space" {
  type        = object({ id = string, name = string })
  description = "cloud.gov space"
}

variable "name" {
  type        = string
  description = "Name of the cg-logshipper application"
  default     = "logshipper"
}

variable "gitref" {
  type        = string
  description = "gitref for the specific version of logshipper that you want to use"
  default     = "refs/heads/main"
  # You can also specify a specific commit, eg "7487f882903b9e834a5133a883a88b16fb8b16c9"
}

# Example:
# service_bindings = {
#   my-service = "",
#   (module.my-other-service.name) = "",
#   yet-another-service = <<-EOT
#      {
#        "astring"     : "foo",
#        "anarray"     : ["bar", "baz"],
#        "anarrayobjs" : [
#          {
#            "name": "bat",
#            "value": "boz"
#        ],
#      }
#      EOT
#   }
# }
variable "service_bindings" {
  description = "A map of service instance name to JSON parameter string."
  type        = map(string)
  default     = {}
}

variable "disk_quota" {
  type        = string
  description = "disk in MB to allocate to cg-logshipper app instance"
  default     = "512M"
}

variable "logshipper_memory" {
  type        = string
  description = "Memory in MB to allocate to cg-logshipper app instance"
  default     = "1046M"
}

variable "logshipper_instances" {
  type        = number
  description = "the number of instances of the cg-logshipper app to run (default: 1)"
  default     = 1
}

variable "https_proxy_url" {
  type        = string
  description = "the full string of the https proxy url for use with the logshipper app"
  sensitive   = true
}

variable "new_relic_license_key" {
  type        = string
  description = "the full string of the new relic license key"
  sensitive   = true
}

variable "new_relic_logs_endpoint" {
  type        = string
  description = "the uri for the logs endpoint"
  default     = "https://gov-log-api.newrelic.com/log/v1"
  # https://docs.newrelic.com/docs/logs/log-api/introduction-log-api/#endpoint
  # The default is the FedRAMP endpoint.
}

variable "syslog_drain_name" {
  type        = string
  description = "the name of the syslog drain that will be created"
  default     = "logdrain"
}


variable "hostname" {
  description = "The hostname to route to. Combined with var.domain for the full route. Defaults to var.name if omitted"
  type        = string
  default     = null
}

variable "domain" {
  description = "The domain part of the application route. Defaults to app.cloud.gov"
  type        = string
  default     = "app.cloud.gov"
}
