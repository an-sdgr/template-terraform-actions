# Main should contain the primary task your terraform configuration performs
# If you are unsure of what to name a singleton resource, main is a good name

# These are all dummy resources and can be safely removed 
resource "tfcoremock_simple_resource" "test" {
  string = "test"
}

resource "tfcoremock_simple_resource" "sensitive" {
  string = var.secret
}
