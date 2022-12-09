
resource "azuread_named_location" "named_location" {
  display_name = var.display_name

  ip {
    ip_ranges = var.ip_ranges
    trusted   = var.trusted
  }
}
