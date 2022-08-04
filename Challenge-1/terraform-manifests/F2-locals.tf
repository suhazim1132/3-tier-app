locals {
  owners = "Mohammed suhail"
  environment = "sandbox"
  common_tags = {
    owners = local.owners
    environment = local.environment
  }
} 