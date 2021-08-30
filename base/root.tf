terraform {}

provider "aws" {
  region                  = "us-east-1"
  alias                   = "use1"
  shared_credentials_file = "~/.aws/credentials"
}