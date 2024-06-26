locals {
  website_files = fileset(var.website_root, "**")
  mime_types = jsondecode(file("mime.json"))
}
