variable "project_id" {
  description = "Project id for the zone."
}

variable "name" {
    description = "Name of the managed DNS zone"
}

variable "domain" {
  description = "Domain name associated with managed zone"
}

variable "recordsets" {
  type = list(object({
    name    = string
    type    = string
    ttl     = number
    rrdatas = list(string)
  }))
  description = "List of DNS record objects to manage, in the standard terraform dns structure."
  default     = []
}