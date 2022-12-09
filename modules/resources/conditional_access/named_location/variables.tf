variable "display_name" {
  type        = string
  description = "The friendly name for the Conditional Access named location"
  default     = null

  validation {
    condition     = var.display_name == null || length(var.display_name) > 4 && length(var.display_name) <= 100
    error_message = "The display_name value must be between 4-100 characters long."
  }
}

variable "ip_ranges" {
  type        = list(string)
  description = "List of IP address ranges in IPv4 CIDR format (e.g. 1.2.3.4/32)."
  default     = [""]

  validation {
    condition     = alltrue([for cidr in var.ip_ranges : can(cidrnetmask("${cidr}"))])
    error_message = "You must provide a valid ipv4 address in cidr notation."
  }
}

variable "trusted" {
  type        = bool
  description = "Whether the named location is trusted. Default is false."
  default     = false
}
