provider "google" {
  # Configuration options
}

module "dns-public-zone" {
  source     = "terraform-google-modules/cloud-dns/google"
  version    = "3.0.0"
  project_id = var.project_id
  type       = "public"
  name       = var.name
  domain     = var.domain
}

output "managed_zone_name" {
    value = module.dns-public-zone.name
}

resource "google_dns_record_set" "records_set" {
  project      = var.project_id
  managed_zone = module.dns-public-zone.name

  for_each = { for record in var.recordsets : join("/", [record.name, record.type]) => record }
  name = (
    each.value.name != "" ?
    "${each.value.name}" :
    var.domain
  )
  type = each.value.type
  ttl  = each.value.ttl

  rrdatas = each.value.rrdatas

  depends_on = [module.dns-public-zone.name]
}