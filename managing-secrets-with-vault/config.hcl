backend "s3" {
  bucket = "vault"
  access_key = "AKIAIPR2HA"
  secret_key = "nO6TK2NAPpZkBf+iSWrnQAojIp"
  region = "eu-west-1"
}

listener "tcp" {
  address = "127.0.0.1:8200"
   tls_disable = 1
}
