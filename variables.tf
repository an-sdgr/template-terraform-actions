# Place all variable declarations here
variable "secret" {
  description = "not actually a secret, used to validate secrets are not leaking to PR comments"
  type        = string
  sensitive   = true
  default     = "DANGER"
}

