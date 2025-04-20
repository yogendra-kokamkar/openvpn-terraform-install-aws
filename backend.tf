terraform {
  backend "s3" {
    bucket       = "terraform-backend-yogendra-us"
    key          = "openvpn"
    region       = "us-east-1"
    use_lockfile = true
  }
}
