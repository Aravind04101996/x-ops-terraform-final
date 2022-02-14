resource "random_password" "dbpassword" {
  length           = 16
  special          = false
}

resource "aws_ssm_parameter" "db_pwd_encoded" {
  name        = "/rds/encoded/dbpwd"
  description = "RDS Postgres Database Password in Base64 Encoded Format"
  type        = "SecureString"
  value       = base64encode(random_password.dbpassword.result)
  overwrite   = true
}