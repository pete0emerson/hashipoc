path "secret/*" {
  capabilities = ["create"]
}

path "secret/password" {
  capabilities = ["read"]
}

path "auth/token/lookup-self" {
  capabilities = ["read"]
}

