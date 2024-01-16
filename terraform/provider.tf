# provider.tf
provider "aws" {
    region = var.region
}

provider "aws" {
    alias  = "eks"
    region = var.region
}
