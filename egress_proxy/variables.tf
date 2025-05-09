variable "cf_org_name" {
  type        = string
  description = "cloud.gov organization name"
}

variable "cf_egress_space" {
  type = object({
    id   = string
    name = string
  })
  description = "cloud.gov space egress"
}

variable "name" {
  type        = string
  description = "name of the egress proxy application"
}

variable "route_host" {
  type        = string
  default     = null
  description = "Hostname to access the egress proxy on apps.internal domain (optional)"
}

variable "egress_memory" {
  type        = string
  description = "Memory to allocate to egress proxy app, including unit"
  default     = "64M"
}

variable "gitref" {
  type        = string
  description = "gitref for the specific version of cg-egress-proxy that you want to use. Branch name should start with `refs/heads` while a git sha should be given without a prefix"
  default     = "refs/heads/main"
  # You can also specify a specific commit, eg "7487f882903b9e834a5133a883a88b16fb8b16c9"
}

variable "allowports" {
  type        = list(number)
  description = "Valid ports to proxy to"
  default     = [443]
}

variable "allowlist" {
  description = "Allowed egress for apps (applied first). A set of allowed acl strings."
  # See the upstream documentation for possible acl strings:
  #   https://github.com/caddyserver/forwardproxy/blob/caddy2/README.md#caddyfile-syntax-server-configuration
  type    = set(string)
  default = [] # [ "*.example.com:443", "example2.com:443" ]
}

variable "denylist" {
  description = "Denied egress for apps (applied second). A set of disallowed host:port strings."
  # See the upstream documentation for possible acl strings:
  #   https://github.com/caddyserver/forwardproxy/blob/caddy2/README.md#caddyfile-syntax-server-configuration
  type    = set(string)
  default = [] # [ "bad.example.com:443" ]
}

variable "instances" {
  type        = number
  description = "the number of instances of the HTTPS proxy application to run (default: 2)"
  default     = 2
}
